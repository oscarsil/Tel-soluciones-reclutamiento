import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/modelos/procesoDeReclutamiento.dart';

class verProceso extends StatefulWidget {
  const verProceso({super.key});

  @override
  State<verProceso> createState() => _verProcesoState();
}

class _verProcesoState extends State<verProceso>{
  late database_helper handler;
  final db = database_helper();
  late Future<List<ProccesoDeContratacion>> procesos;

  @override
  void initState() {
    handler = database_helper();
    procesos = handler.getProcesos();
    handler.initDB().whenComplete(
            () {
          procesos = getAllProcesos();
        }
    );
    super.initState();
  }

  Future<List<ProccesoDeContratacion>> getAllProcesos() {
    return handler.getProcesos();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ver Procesos"),),
      body: FutureBuilder<List<ProccesoDeContratacion>>(
        future: procesos,
        builder: (BuildContext context, AsyncSnapshot<List<ProccesoDeContratacion>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasData && snapshot.data!.isEmpty){
            return Text("no data");
          }else if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }else{
            final items = snapshot.data ?? <ProccesoDeContratacion>[];
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
                            TableCell(child: Text("id reclutante")),
                            TableCell(child: Text("id prospecto")),
                            TableCell(child: Text("pts")),
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
                                  TableCell(child: Text(items[index].id.toString())),
                                  TableCell(child: Text(items[index].nombreReclutador)),
                                  TableCell(child: Text(items[index].idReclutante.toString())),
                                  TableCell(child: Text(items[index].idProspecto.toString())),
                                  TableCell(child: Text(items[index].pts)),
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
        },
      ),
    );
  }

}