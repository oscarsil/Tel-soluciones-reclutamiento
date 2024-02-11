import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';
import 'package:telsolreclutamiento/modelos/procesoDeReclutamiento.dart';
import 'package:telsolreclutamiento/database_helper.dart';

class DashboardJefe extends StatefulWidget{
  final String fecha;

  const DashboardJefe({
    required this.fecha
});

  @override
  State<DashboardJefe> createState() => _DashboardJefeState();
}

class _DashboardJefeState extends State<DashboardJefe> {
  late database_helper handler;
  final db = database_helper();
  late Future<List<ProccesoDeContratacion>> procesos;

  @override
  void initState() {
    handler = database_helper();
    procesos = handler.procesosHoy(widget.fecha);
    handler.initDB().whenComplete(
            () {
          procesos = getAllProcesos();
        }
    );
    super.initState();
  }

  Future<List<ProccesoDeContratacion>> getAllProcesos() {
    return handler.procesosHoy(widget.fecha);
  }

  Future<String> califiacionProspecto(int? id) async{
    return db.caliProspecto(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize:  Size.fromHeight(50),
          child: barraSalir(titulo: 'Dashboard Jefe de Reclutamiento')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: barraslaterales(),
          ),
          Expanded(
            flex: 5,
            child: FutureBuilder<List<ProccesoDeContratacion>>(
              future: procesos,
              builder: (BuildContext context, AsyncSnapshot<List<ProccesoDeContratacion>> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }else if(snapshot.hasData && snapshot.data!.isEmpty){
                  return Center(child: const Text("Todavia no hay Prospectos Entrevistados por Hoy"));
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
                          Table(
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
                          ListView.builder(
                              itemCount: items.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Table(
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
                                                  return const Text("waiting");
                                                }else if (text.hasData && text.data!.isEmpty){
                                                  return const Text("no data");
                                                }else if(text.hasError){
                                                  return Text(text.error.toString());
                                                }else{
                                                  return   new Text(text.data as String);
                                                }
                                              })
                                          ),
                                          TableCell(child:  items[index].nombreReclutador == null ? Text("Reclutador no asignado") : Text(items[index].nombreReclutador.toString())),
                                          //items[index].nombreReclutador.toString()
                                          TableCell(child: Text(items[index].pts)),
                                        ]
                                    ),
                                  ],
                                );
                              }
                          ),
                        ],
                      );
                      },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
