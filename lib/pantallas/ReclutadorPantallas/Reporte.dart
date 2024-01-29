import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';
import 'package:telsolreclutamiento/database_helper.dart';

class Reporte extends StatefulWidget{
  final String desde;
  final String hasta;
  const Reporte({
    required this.desde,
    required this.hasta,
    super.key
  });
  @override
  State<Reporte> createState() => _ReporteState();
}

class _ReporteState extends State<Reporte> {
  final formKey = GlobalKey<FormState>();
  final db = database_helper();

  late database_helper handler;
  late Future<List<Reclutador>> reclutadores;

  @override
  void initState() {
    handler = database_helper();
    reclutadores = handler.getReclutadores();
    handler.initDB().whenComplete(
            () {
          reclutadores = getAllReclutadores();
        }
    );
    super.initState();
  }

  Future<List<Reclutador>> getAllReclutadores() {
    return handler.getReclutadores();
  }

  Future<String> function(int? id) async {
    return db.getCount(id,widget.desde,widget.hasta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("prueba de reporte",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Reclutador>>(
        future: reclutadores,
        builder: (BuildContext context, AsyncSnapshot<List<Reclutador>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(snapshot.hasData && snapshot.data!.isEmpty){
            return const Text("no data");
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }else{
            final items = snapshot.data ?? <Reclutador>[];
            return ListView.builder(
                itemCount: 1,
                //error aqui
                itemBuilder: (context, index){
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
                                TableCell(child: Align(alignment: Alignment.center,child: Text("id",style: TextStyle(color: Colors.white),))),
                                TableCell(child:  Align(alignment: Alignment.center,child:Text("nombre",style: TextStyle(color: Colors.white)))),
                                TableCell(child:  Align(alignment: Alignment.center,child:Text('Entrevistados',style: TextStyle(color: Colors.white))),),
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
                                      TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].username))),
                                      TableCell(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: FutureBuilder(
                                                future: function(items[index].id),
                                                builder: (BuildContext context, AsyncSnapshot<String> text){
                                                  if(text.connectionState == ConnectionState.waiting){
                                                    return const Text("waiting");
                                                  }else if (text.hasData && text.data!.isEmpty){
                                                    return const Text("no data");
                                                  }else if(text.hasError){
                                                    return Text(text.error.toString());
                                                  }else{
                                                    return Text(text.data as String);
                                                  }
                                                }),
                                          )
                                      )
                                    ]
                                ),
                              ],
                            );
                          }
                      ),
                    ],
                  );
                }
            );
          }
        },
      ),
    );
  }
}