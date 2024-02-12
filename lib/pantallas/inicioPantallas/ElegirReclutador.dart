import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/pantallas/ProcesoPantallas/ElegirProspecto.dart';
import 'package:telsolreclutamiento/pantallas/inicioPantallas/introducirIdProspecto.dart';

class ElegirReclu extends StatefulWidget{
  const ElegirReclu({super.key});

  @override
  State<ElegirReclu> createState() => _ElegirRecluState();
}

class _ElegirRecluState extends State<ElegirReclu> {
  late database_helper handler;
  late Future<List<Reclutador>> reclutadores;
  final db = database_helper();




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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reclutadores'),
      ),
      body: FutureBuilder<List<Reclutador>>(
          future: reclutadores,
          builder: (BuildContext context, AsyncSnapshot<List<Reclutador>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }else if(snapshot.hasData && snapshot.data==""){
                return Center(child: const Text("no hay reclutadores activos para proceder con la aplicaicon de examenes"));
              }else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }else{
                final items = snapshot.data ?? <Reclutador>[];
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(items[index].username),
                        subtitle: Text(items[index].id.toString()),
                        onTap: () {
                         //Navigator.push(context, MaterialPageRoute(builder: (context) => ElegirPros(idReclu: items[index].id, UsernameReclu: items[index].username)));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => introducirIdProspecto(idReclu: items[index].id, UsernameReclu: items[index].username)));
                        },
                      );
                    });
              }
          })
    );
  }
}