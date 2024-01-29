import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';

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
      appBar: const PreferredSize(preferredSize:  Size.fromHeight(50), child: barraRegSal(titulo: "borrar reclutador")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<Reclutador>>(
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
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Table(
                      children:
                      const <TableRow>[
                        TableRow(
                            decoration: BoxDecoration(
                              color: Colors.orange
                            ),
                            children: [
                              TableCell(child: Align(alignment: Alignment.center,child: Text("Id", style: TextStyle(color: Colors.white),))),
                              TableCell(child: Align(alignment: Alignment.center,child: Text("Nombre", style: TextStyle(color: Colors.white),))),
                              TableCell(child: Align(alignment: Alignment.center,child:Text("Delete", style: TextStyle(color: Colors.white),)))
                            ]
                        )],
                    ),
                    ListView.builder(
                      itemCount: items.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return Table(
                          children: <TableRow>[
                            TableRow(
                                children: [
                                  TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].id.toString(),style: const TextStyle(fontWeight: FontWeight.w500),))),
                                  TableCell(child: Align(alignment: Alignment.center,child: Text(items[index].username,style: const TextStyle(fontWeight: FontWeight.w500),))),
                                  TableCell(child: Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 25,
                                    child: ElevatedButton(
                                        onPressed: () {
                                      setState(() {
                                        db.borrarReclutador(int.parse(items[index].id.toString())).whenComplete(_refresh);
                                      });
                                    }, child: const Icon(Icons.delete_forever_outlined)),
                                  ))
                                ]
                            )
                          ],
                        );
                      },
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
      );
  }
}