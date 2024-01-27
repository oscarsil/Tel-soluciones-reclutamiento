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
        title: Text("prueba de reporte"),
      ),
      body: FutureBuilder<List<Reclutador>>(
        future: reclutadores,
        builder: (BuildContext context, AsyncSnapshot<List<Reclutador>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasData && snapshot.data!.isEmpty){
            return Text("no data");
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
                      Container(
                        child: Table(
                            children: const <TableRow>[
                              TableRow(
                                children: [
                                  TableCell(child: Text("id",)),
                                  TableCell(child: Text("nombre")),
                                  TableCell(child: Text('Entrevistados'),),
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
                                        TableCell(child: Text(items[index].username)),
                                        TableCell(
                                            child: FutureBuilder(
                                                future: function(items[index].id),
                                                builder: (BuildContext context, AsyncSnapshot<String> text){
                                                  if(text.connectionState == ConnectionState.waiting){
                                                    return Text("waiting");
                                                  }else if (text.hasData && text.data!.isEmpty){
                                                    return Text("no data");
                                                  }else if(text.hasError){
                                                    return Text(text.error.toString());
                                                  }else{
                                                    return new Text(text.data as String);
                                                  }
                                                })
                                        )
                                      ]
                                  ),
                                ],
                              ),
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