import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/ReporteReclutador.dart';

class borrarReclu extends StatefulWidget{
  const borrarReclu({super.key});

  @override
  State<borrarReclu> createState() => _borrarRecluState();
}

class _borrarRecluState extends State<borrarReclu> {

  late database_helper handler;
  late Future<List<Reclutador>> reclutadores;
  final db = database_helper();

  Future<void> _refresh() async{
    setState(() {
      reclutadores = getallReclutadores();
    });
  }

  @override
  void initState() {
    handler = database_helper();
    reclutadores = handler.getReclutadores();
    handler.initDB().whenComplete(() {
      reclutadores = getallReclutadores();
    });
    super.initState();
  }

  Future <List<Reclutador>> getallReclutadores(){
    return handler.getReclutadores();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(child: barraRegSal(titulo: "borrar reclutador"), preferredSize: const Size.fromHeight(50)),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<List<Reclutador>>(
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
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          child: Table(
                            children:
                            const <TableRow>[
                              TableRow(
                                  children: [
                                    TableCell(child: Text("id")),
                                    TableCell(child: Text("nombre")),
                                    TableCell(child: Text("Delete"))
                                  ]
                              )],
                          )
                      ),
                      ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Container(
                            child: Table(
                              children: <TableRow>[
                                TableRow(
                                    children: [
                                      TableCell(child: Text(items[index].id.toString())),
                                      TableCell(child: Text(items[index].username)),
                                      TableCell(child: ElevatedButton(onPressed: () {
                                        setState(() {
                                          db.borrarReclutador(int.parse(items[index].id.toString())).whenComplete(_refresh);
                                        });
                                      }, child: Icon(Icons.delete_forever_outlined)))
                                    ]
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ],
        )),
      );
  }
}