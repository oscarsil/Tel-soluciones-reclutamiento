import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/quizz.dart';

class instruccionesQuizz extends StatefulWidget{
  final int prospecto_int;

  const instruccionesQuizz({required this.prospecto_int});

  @override
  State<instruccionesQuizz> createState() => _instruccionesQuizzState();
}

class _instruccionesQuizzState extends State<instruccionesQuizz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize:  Size.fromHeight(50),child:barraInformativa(titulo:'instrucciones para el Quizz')),
      body: Center(
        child: Column(
          children: [
            Container(width: 750,child: const Wrap(children: [ Text('A continuacion se presentara una serie de examenes que tiene que responder.; El primero de estos es un Quizz, va venir la pregunta en el centro de la pantalla y abajo se van encontrar cuarto opciones y usted tendra que elegir el boton con la respuesta correcta ')])),
            ElevatedButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => quizz(prospecto_int: widget.prospecto_int)));
            }, child: const Text('Comenzar'))
          ],
        ),
      ),
    );
  }
}