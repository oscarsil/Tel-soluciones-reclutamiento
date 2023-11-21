import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/examenAuditivo.dart';

class instruccionesExamenAuditivo extends StatelessWidget{
  const instruccionesExamenAuditivo({super.key});

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
              MaterialPageRoute(builder: (builder) => examenAuditivo()));
            }, child: Text('Comenzar'))
          ],
        ),
      ),
    );
  }
}