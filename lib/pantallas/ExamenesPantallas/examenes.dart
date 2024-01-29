import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamAudio.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/quizz.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/Apto.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamenTecleado.dart';
import 'package:telsolreclutamiento/pantallas/ProcesoPantallas/LeerProcesos.dart';

class examenes extends StatelessWidget {
  const examenes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize:  Size.fromHeight(50),
          child: barraInformativa(titulo: 'Tel-Soluciones')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => quizz(prospecto_int: 101,)));
            }, child: const Text('quiiz')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => instruccionesExamenTeclado(prospecto_id: 101,quizzscore: 100,)));
            }, child: const Text('Tecleado')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const instruccionesExamenAuditivo(prospecto_id: 101,quizzscore: 100, tecladoscore: 45,)));
            }, child: const Text('Auditivo')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DashboardReclutador()));
            }, child: const Text('Dashboard reclutador')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const apto(prospecto_id: 102, quizzscore: 100, tecladoscore: 42, auditivoscore: 80))
              );
            }, child: const Text('Apto')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const verProceso())
              );
            }, child: const Text('ver proceso'))
          ],
        ),
      ),
    );
  }
}