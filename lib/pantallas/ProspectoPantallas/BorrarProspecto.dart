import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';

class borrarProspecto extends StatefulWidget{
  const borrarProspecto({super.key});

  @override
  State<borrarProspecto> createState() => _borrarProspectoState();
}

class _borrarProspectoState extends State<borrarProspecto> {
  late database_helper handler;
  late Future<List<Prospecto>> prospectos;
  final db = database_helper();
  final Keyword = TextEditingController();

  @override
  void dispose(){
    Keyword.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize:  Size.fromHeight(50),
            child: barraRegSal(titulo: 'borrar Prospecto')),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
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
                  Expanded(child: FutureBuilder<List<Prospecto>>(
                    future: prospectos,
                    builder: (BuildContext context, AsyncSnapshot<List<Prospecto>> snapshot){

                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasData && snapshot.data!.isEmpty){
                        return const Text("no data");
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
                                      TableCell(child: Align(alignment: Alignment.center,child: Text("id", style: TextStyle(color: Colors.white)))),
                                      TableCell(child: Align(alignment: Alignment.center,child: Text("nombre", style: TextStyle(color: Colors.white)))),
                                      TableCell(child: Align(alignment: Alignment.center,child: Text("primer apellido", style: TextStyle(color: Colors.white)))),
                                      TableCell(child: Align(alignment: Alignment.center,child: Text("segundo apellido", style: TextStyle(color: Colors.white)))),
                                      TableCell(child: Align(alignment: Alignment.center,child: Text("motivo", style: TextStyle(color: Colors.white)))),
                                      TableCell(child: Align(alignment: Alignment.center,child: Text("Estatus", style: TextStyle(color: Colors.white)))),
                                      TableCell(child: Align(alignment: Alignment.center,child: Icon(Icons.delete,color: Colors.white,)))
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
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: Text(items[index].id.toString()))),
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: Text(items[index].nombre))),
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: Text(items[index].primerApellido))),
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: Text(items[index].segundoApellido))),
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: Text(items[index].motivo.toString()))),
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: Text(items[index].estatus.toString()))),
                                            TableCell(verticalAlignment: TableCellVerticalAlignment.middle,child: Align(alignment: Alignment.center,child: IconButton(onPressed: () {
                                              setState(() {
                                                db.borrarProspecto(int.parse(items[index].id.toString())).whenComplete(_refresh);
                                              });
                                            }, icon: const Icon(Icons.delete))))
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
                  )
                ],
              ),
            )
          ],
        ));
  }
}