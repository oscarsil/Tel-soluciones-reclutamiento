import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';
import 'package:telsolreclutamiento/database_helper.dart';

class JefeReclutadorPrincipal extends StatefulWidget{
  const JefeReclutadorPrincipal({super.key});

  @override
  State<JefeReclutadorPrincipal> createState() => _JefeReclutadorPrincipalState();
}

class _JefeReclutadorPrincipalState extends State<JefeReclutadorPrincipal> {
  late database_helper handler;
  late Future<List<Prospecto>> prospectos;
  final db = database_helper();
  final Keyword = TextEditingController();

  @override
  void dispose(){
    Keyword.dispose();
  }

  @override
  void initState() {
    handler = database_helper();
    prospectos = handler.getProspectos();
    handler.initDB().whenComplete(() {
      prospectos = getallProspectos();
    });
    super.initState();
  }

  Future<List<Prospecto>> getallProspectos(){
    return handler.getProspectos();
  }

  Future<List<Prospecto>> searchProspecto(){
    return handler.searchProspecto(Keyword.text);
  }


  Future<void> _refresh() async {
    setState(() {
      prospectos = getallProspectos();
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: barraSalir(titulo: 'Jefe de Reclutamiento')),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: barraslaterales(),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextFormField(
                      controller: Keyword,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          setState(() {
                            prospectos = searchProspecto();
                          });
                        }else{
                          setState(() {
                            prospectos = getallProspectos();
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                          hintText: "search"
                      ),
                    ),
                  ),
                  Expanded(child: FutureBuilder<List<Prospecto>>(
                    future: prospectos,
                    builder: (BuildContext context, AsyncSnapshot<List<Prospecto>> snapshot){

                      if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }else if(snapshot.hasData && snapshot.data!.isEmpty){
                        return Text("no data");
                      }else if(snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }else{
                        final items = snapshot.data ?? <Prospecto>[];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Table(

                                  children: const <TableRow>[
                                    TableRow(
                                      children: [
                                        TableCell(child: Text("id",)),
                                        TableCell(child: Text("nombre")),
                                        TableCell(child: Text("primer apellido")),
                                        TableCell(child: Text("segundo apellido")),
                                        TableCell(child: Text("direccion")),
                                        TableCell(child: Text("telefono")),
                                        TableCell(child: Text("calquizz")),
                                        TableCell(child: Text("calexamtex")),
                                        TableCell(child: Text("calexamaud")),
                                        TableCell(child: Text("campaña")),
                                        TableCell(child: Text("motivo")),
                                        TableCell(child: Text("Estatus")),
                                        TableCell(child: Text("Edad")),
                                        TableCell(child: Text("escolaridad")),
                                      ],
                                    ),]
                              ),
                            ),
                            ListView.builder(
                                itemCount: items.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index)
                                {
                                  return Container(
                                    child: Table(
                                      children: <TableRow>[
                                        TableRow(
                                            children:
                                            [
                                              TableCell(child: Text(items[index].id.toString())),
                                              TableCell(child: Text(items[index].nombre)),
                                              TableCell(child: Text(items[index].primerApellido)),
                                              TableCell(child: Text(items[index].segundoApellido)),
                                              TableCell(child: Text(items[index].direccion)),
                                              TableCell(child: Text(items[index].telefono)),
                                              TableCell(child: Text(items[index].calquizz.toString())),
                                              TableCell(child: Text(items[index].calexamTec.toString())),
                                              TableCell(child: Text(items[index].calexamAud.toString())),
                                              TableCell(child: Text(items[index].campana.toString())),
                                              TableCell(child: Text(items[index].motivo.toString())),
                                              TableCell(child: Text(items[index].estatus.toString())),
                                              TableCell(child: Text(items[index].edad.toString())),
                                              TableCell(child: Text(items[index].escolaridad)),
                                            ]
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      }
                    },
                  ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}