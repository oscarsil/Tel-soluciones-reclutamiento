import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';
import 'package:telsolreclutamiento/modelos/procesoDeReclutamiento.dart';
import 'package:intl/intl.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesQuizz.dart';

class ElegirPros extends StatefulWidget{
  final int? idReclu;
  final String UsernameReclu;
  const ElegirPros({
    required this.idReclu,
    required this.UsernameReclu,
    super.key
  });

  @override
  State<ElegirPros> createState() => _ElegirProsState();
}

class _ElegirProsState extends State<ElegirPros> {



  String getDate(){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  late database_helper handler;
  late Future<List<Prospecto>> prospectos;
  final db = database_helper();

  @override
  void initState() {
    handler = database_helper();
    prospectos = handler.noscore();
    handler.initDB().whenComplete(() {
      prospectos = getallProspectos();
    });
    super.initState();
  }

  Future<List<Prospecto>> getallProspectos(){
    return handler.noscore();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prospectos sin calificacion'),),
      body: FutureBuilder<List<Prospecto>>(
        future: prospectos,
        builder: (BuildContext context, AsyncSnapshot<List<Prospecto>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(snapshot.hasData && snapshot.data!.isEmpty){
            return const Text("no data");
          }else if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }else{
            final items = snapshot.data ?? <Prospecto>[];
            return  ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(items[index].nombre +" "+items[index].primerApellido + " "+items[index].segundoApellido),
                        onTap: () {
                          db.crearProceso(ProccesoDeContratacion(
                              nombreReclutador: widget.UsernameReclu,
                              idReclutante: widget.idReclu,
                              nombreProspecto: items[index].nombre +" "+items[index].primerApellido + " "+items[index].segundoApellido,
                              idProspecto: items[index].id,
                              pts: getDate())
                          ).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => instruccionesQuizz(prospecto_int: items[index].id!))));
                        },
                      );
                    }

                );
          }
        },
      ),
    );
  }
}
