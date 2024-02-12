import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/modelos/procesoDeReclutamiento.dart';
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
  late Future<List<ProccesoDeContratacion>> procesos;

  @override
  void initState() {
    handler = database_helper();
    procesos = handler.ProcesosFecha(widget.desde, widget.hasta);
    handler.initDB().whenComplete(
            () {
              procesos = getAllProcesos();
        }
    );
    super.initState();
  }

  Future<List<ProccesoDeContratacion>> getAllProcesos() {
    return handler.ProcesosFecha(widget.desde, widget.hasta);
  }

  Future<String> califiacionProspecto(int? id) async{
    return db.caliProspecto(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reporte",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<ProccesoDeContratacion>>(
        future: procesos,
        builder: (BuildContext context, AsyncSnapshot<List<ProccesoDeContratacion>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasData && snapshot.data!.isEmpty){
            return Center(child: Text("no se encontro Prospectos entrevistados con los filtros de busqueda"));
          }else if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }else{
            final items = snapshot.data ?? <ProccesoDeContratacion>[];
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Table(
                          children: const <TableRow>[
                            TableRow(
                              children: [
                                TableCell(child: Text("Nombre Prospecto",)),
                                TableCell(child: Text("Calificaciones(quizz, tecleado,auditivo)")),
                                TableCell(child: Text("nombre reclutador")),
                                TableCell(child: Text("fecha de inicio de proceso")),
                              ],
                            ),]
                      ),
                    ),
                    ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Table(
                              children: <TableRow>[
                                TableRow(
                                    children:
                                    [
                                      TableCell(child: Text(items[index].nombreProspecto)),
                                      /*
                                      TableCell(
                                          child: FutureBuilder(
                                              future: NombreProspecto(items[index].idProspecto),
                                              builder: (BuildContext context, AsyncSnapshot<String> text){
                                                if(text.connectionState == ConnectionState.waiting){
                                                  return Text("waiting");
                                                }else if (text.hasData && text.data!.isEmpty){
                                                  return Text("no data");
                                                }else if(text.hasError){
                                                  return Text(text.error.toString());
                                                }else{
                                                  return   new Text(text.data as String);
                                                }
                                              })),

                                       */
                                      TableCell(child: FutureBuilder(future: califiacionProspecto(items[index].idProspecto),
                                          builder: (BuildContext context, AsyncSnapshot<String> text){
                                            if(text.connectionState == ConnectionState.waiting){
                                              return Text("waiting");
                                            }else if (text.hasData && text.data!.isEmpty){
                                              return Text("no data");
                                            }else if(text.hasError){
                                              return Text(text.error.toString());
                                            }else{
                                              return   new Text(text.data as String);
                                            }
                                          })
                                      ),
                                      TableCell(child: Text(items[index].nombreReclutador.toString())),
                                      TableCell(child: Text(items[index].pts)),
                                    ]
                                ),
                              ],
                            ),
                          );
                        }
                    ),
                  ],
                );},
            );
          }
        },
      ),
    );
  }
}