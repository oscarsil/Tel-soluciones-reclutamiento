import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import '../ExamenesPantallas/instruccionesQuizz.dart';

class nombreProspecto extends StatefulWidget {
  final int id;
  final int? idReclu;
  final String UsernameReclu;

  const nombreProspecto({
    required this.id,
    required this.idReclu,
    required this.UsernameReclu,
    super.key});

  @override
  State<nombreProspecto> createState() => _nombreProspectoState();
}

class _nombreProspectoState extends State<nombreProspecto> {
  late database_helper handler;
  late Future<String> resultado;
  final db = database_helper();

  String getDate(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  @override
  void initState() {
    handler = database_helper();
    resultado = handler.obtenerNombreProspecto(widget.id);
    handler.initDB().whenComplete(() {
      resultado = getResultado();
    });
    super.initState();
  }

  Future<String> getResultado() {
    return handler.obtenerNombreProspecto(widget.id);
  }

  Future<int?> getIdProceso(nombre, idProspecto, pts) async{
    int? x = await db.getIDproceso(nombre, idProspecto, pts);
    return x;
  }

  late int? IDproseco;

  void asignarIdProseco(nombre, idProspecto, pts) async {
    IDproseco = await getIdProceso(nombre, idProspecto, pts);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resultado de busqueda"),),
      body: FutureBuilder(future: resultado,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Text("no existe Prospecto con ese id");
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final name = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text(name!,style: TextStyle(fontSize: 40),),
                  SizedBox(height: 20,),
                  Text("Esta correcto el Nombre"),
                  SizedBox(height: 25,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
            crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () {
                        asignarIdProseco(name, widget.id, getDate());
                        db.editarProceso(IDproseco, widget.UsernameReclu, widget.idReclu).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => instruccionesQuizz(prospecto_int: widget.id))));
                      }, child: Text("Si")),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: Text("No"))
                    ],
                  )
                ],
              );
            }
          }),
    );
  }
}