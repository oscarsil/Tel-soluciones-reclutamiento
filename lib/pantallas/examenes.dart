import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/instruccionesExamAudio.dart';
import 'package:telsolreclutamiento/pantallas/quizz.dart';
import 'package:telsolreclutamiento/pantallas/examenTecleo.dart';
import 'package:telsolreclutamiento/pantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/resultados.dart';

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
                  MaterialPageRoute(builder: (context) => quizz()));
            }, child: Text('quiiz')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => examenTeclado()));
            }, child: Text('Tecleado')),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => instruccionesExamenAuditivo()));
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