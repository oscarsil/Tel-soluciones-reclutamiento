import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';
import 'package:telsolreclutamiento/modelos/procesoDeReclutamiento.dart';
import 'package:telsolreclutamiento/database_helper.dart';

class DashboardReclu extends StatefulWidget{
  final String fecha;

  const DashboardReclu({
    required this.fecha
});

  @override
  State<DashboardReclu> createState() => _DashboardRecluState();
}

class _DashboardRecluState extends State<DashboardReclu> {
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
          child: barraSalir(titulo: 'Dashboard Reclutador')),
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueAccent,
                child: barraRelcutador(),
              ),
            ),
          Expanded(
            flex: 7,
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
                                  decoration: BoxDecoration(
                                      color: Colors.orange
                                  ),
                                  children: [
                                    TableCell(child:Align(alignment: Alignment.center,child: Text("Nombre Prospecto",style: TextStyle(color: Colors.white),))),
                                    TableCell(child:Align(alignment: Alignment.center,child: Text("Calificaciones(quizz, tecleado,auditivo)",style: TextStyle(color: Colors.white),))),
                                    TableCell(child:Align(alignment: Alignment.center,child: Text("nombre reclutador",style: TextStyle(color: Colors.white),))),
                                    TableCell(child: Align(alignment: Alignment.center,child:Text("fecha de inicio de proceso",style: TextStyle(color: Colors.white),))),
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
                                          TableCell(child:Align(alignment: Alignment.center,child: Text(items[index].nombreProspecto))),
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
                                          TableCell(child:Align(alignment: Alignment.center,child: FutureBuilder(future: califiacionProspecto(items[index].idProspecto),
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
                                              }))
                                          ),
                                          TableCell(child: Align(alignment: Alignment.center,child: items[index].nombreReclutador == null ? Text("Reclutador no asignado") : Text(items[index].nombreReclutador.toString()))),
                                          TableCell(child: Align(alignment: Alignment.center,child:Text(items[index].pts))),
                                        ]
                                    ),
                                  ],
                                );
                              }
                          ),
                        ],
                      );},
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}