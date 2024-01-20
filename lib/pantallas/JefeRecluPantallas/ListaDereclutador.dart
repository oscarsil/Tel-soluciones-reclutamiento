import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/CrearReclutador.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/EditarReclutador.dart';
import 'dart:core';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';

class ListaDeReclutadores extends StatefulWidget{

  const ListaDeReclutadores({super.key});

  @override
  State<ListaDeReclutadores> createState() => _ListaDeReclutadoresState();
}

class _ListaDeReclutadoresState extends State<ListaDeReclutadores> {
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
  Widget build(BuildContext context){
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: barraRegSal(titulo: 'Jefe de Reclutamiento')),
        body: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blueAccent,
                    child: barraslaterales(),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                      color: Colors.white,
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
                                                    TableCell(child: Text("nombre"))
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
                                                        TableCell(child: Text(items[index].username))
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CrearReclutador()));
                                  },
                                  child: Text('Nuevo reclutador',
                                      style: TextStyle(color: Colors.white))),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditarReclutador()));
                                  },
                                  child: Text('Actualizar reclutador',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          )
                        ],
                      )),
                )
              ],
            )
        ));
  }
}