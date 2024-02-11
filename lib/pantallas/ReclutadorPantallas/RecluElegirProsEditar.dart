import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/pantallas/ProspectoPantallas/EditarProspecto.dart';

class RecluElegirProsEditar extends StatefulWidget{
  const RecluElegirProsEditar({super.key});

  @override
  State<RecluElegirProsEditar> createState() => _RecluElegirProsEditarState();
}

class _RecluElegirProsEditarState extends State<RecluElegirProsEditar> {
  late database_helper handler;
  late Future<List<Prospecto>> prospectos;
  final db = database_helper();
  final Keyword = TextEditingController();




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
      appBar: const PreferredSize(
          preferredSize:  Size.fromHeight(50),
          child: barraSalir(titulo: 'Reclutador')),
      body: Center(
        child: Row(
          children: [
            /*Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueAccent,
                child: barraRelcutador(),
              ),
            ),*/
            Expanded(
              flex: 7,
              child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      FutureBuilder<List<Prospecto>>(
                            future: prospectos,
                            builder: (BuildContext context, AsyncSnapshot<List<Prospecto>> snapshot){

                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const CircularProgressIndicator();
                              }else if(snapshot.hasData && snapshot.data!.isEmpty){
                                return const Text("No hay prospectos entrevistados el dia de hoy o que coinciden con la busqueda");
                              }else if(snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }else{
                                final items = snapshot.data ?? <Prospecto>[];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Table(

                                        children: const <TableRow>[
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: Colors.orange
                                            ),
                                            children: [
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Id",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Nombre",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Primer Apellido",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Segundo Apellido",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Direccion",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Telefono",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Quizz",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Calificacion PPM",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Audio",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Campaña",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Motivo",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Estatus",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Edad",style: TextStyle(color: Colors.white),))),
                                              TableCell(child: Align(alignment: Alignment.center,child: Text("Escolaridad",style: TextStyle(color: Colors.white),))),
                                            ],
                                          ),]
                                    ),
                                    ListView.builder(
                                        itemCount: items.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index)
                                        {
                                          return Table(
                                            children: <TableRow>[
                                              TableRow(
                                                  children:
                                                  [
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].id.toString()))),
                                                    TableCell(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(builder: (context) => EditarProspecto(pros: items[index]))
                                                                ).then((value) => _refresh());
                                                              },
                                                              child: Text(items[index].nombre
                                                              )),
                                                        )
                                                    ),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].primerApellido))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].segundoApellido))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].direccion))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].telefono))),
                                                    TableCell(child:Align(alignment: Alignment.center,child: items[index].calquizz == null ? Text("sin aplicar") : Text(items[index].calquizz.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: items[index].calexamTec == null ? Text("sin aplicar") : Text(items[index].calexamTec.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: items[index].calexamAud == null ? Text("sin aplicar") : Text(items[index].calexamAud.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].campana.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child:items[index].motivo == null ? Text("N/A") : Text(items[index].motivo.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: items[index].estatus == null ? Text("sin estatus") : Text(items[index].estatus.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].edad.toString()))),
                                                    TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].escolaridad))),
                                                  ]
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                );
                              }
                            },
                          ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }


}