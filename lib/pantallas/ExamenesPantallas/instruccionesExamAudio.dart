import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/examenAuditivo.dart';

class instruccionesExamenAuditivo extends StatelessWidget{
  final int prospecto_id;
  final int quizzscore;
  final double tecladoscore;
  const instruccionesExamenAuditivo({required this.prospecto_id,required this.quizzscore, required this.tecladoscore});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),child:barraInformativa(titulo:'instrucciones para el Examen de Auditivo')),
      body: Center(
        child: Column(
          children: [
            Text('El siguiente es un examen auditivo, donde despues de presionar el boton comenzar,tendran dos minutos para escuchar el audio y  seleccionar las respuestas correctas'),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (builder) => examenAuditivo(prospecto_id: this.prospecto_id, quizzscore:this.quizzscore,tecladoscore: 45,)));
            }, child: Text('Comenzar'))
          ],
        ),
      ),
    );
  }
}