import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamAudio.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/quizz.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/Apto.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamenTecleado.dart';

class examenes extends StatelessWidget {
  const examenes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: barraInformativa(titulo: 'Tel-Soluciones')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              print("101");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => quizz(prospecto_int: 101,)));
            }, child: Text('quiiz')),
            ElevatedButton(onPressed: () {
              print("101 100");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => instruccionesExamenTeclado(prospecto_id: 101,quizzscore: 100,)));
            }, child: Text('Tecleado')),
            ElevatedButton(onPressed: () {
              print("101 100 45");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => instruccionesExamenAuditivo(prospecto_id: 101,quizzscore: 100, tecladoscore: 45,)));
            }, child: Text('Auditivo')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardReclutador()));
            }, child: Text('Dashboard reclutador')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => apto(prospecto_id: 102, quizzscore: 100, tecladoscore: 42, auditivoscore: 80))
              );
            }, child: Text('Apto'))
          ],
        ),
      ),
    );
  }
}