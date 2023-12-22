import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamAudio.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/quizz.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/resultados.dart';
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => quizz(prospecto_int: 101,)));
            }, child: Text('quiiz')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => instruccionesExamenTeclado(prospecto_id: 101,quizzscore: 100,)));
            }, child: Text('Tecleado')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => instruccionesExamenAuditivo(prospecto_id: 101,quizzscore: 100, tecladoscore: 45,)));
            }, child: Text('Auditivo')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardReclutador()));
            }, child: Text('Dashboard reclutador')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Resultados(time: 30, length: 13, errors: 2))
              );
            }, child: Text('PRUEBA'))
          ],
        ),
      ),
    );
  }
}