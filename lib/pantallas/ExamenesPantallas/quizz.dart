import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamenTecleado.dart';

var preguntas_basicas = [
  '',
  'como copiar un texto en la computadora usando el tecleado',
  'como hacerle zoom a la pantalla con el tecleado',
  'cual de los siguientes es una dirección de web válida',
  'cuales son las dos opciones para refrescar una pagina',
  'cual de estos botones permite escribir en mayusculas',
  '',
];

var respuestas_basicas = [
  '',
  'CTRL C',
  'CTRL +',
  'www.google.com',
  'F5',
  'Caps lock',
  '',
];

var opciones = [
  [],
  ['CTRL C', 'CTRL V', 'SHIFT C', 'TAB'],
  ['TAB', 'F2', 'CTRL +', 'CTRL Z'],
  ['googlecom', 'www.google.com', 'google-com', 'google'],
  ['F5', 'ALT 4', 'F9', 'CTRL R'],
  ['F6', 'DELETE', 'CTRL V', 'Caps lock'],
  [],
];

class quizz extends StatefulWidget {
  final int prospecto_int;
  const quizz({required this.prospecto_int});
  @override
  State<quizz> createState() => _quizzState();
}

var question_pointer = 1;
int score = 0;
int finalscore = 0;

class _quizzState extends State<quizz> {
  int contador_Preguntas = question_pointer;
  String pregunta = preguntas_basicas[question_pointer];
  String opcion1 = opciones[question_pointer][0];
  String opcion2 = opciones[question_pointer][1];
  String opcion3 = opciones[question_pointer][2];
  String opcion4 = opciones[question_pointer][3];
  String puntuaje = '0';

  void actualizarPregunta() {
    setState(() {
      if (question_pointer == 5) {
        puntuaje = '0';
        resetearexamen();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => instruccionesExamenTeclado(
                      prospecto_id: this.widget.prospecto_int,
                      quizzscore: finalscore * 2,
                    )));
      } else {
        question_pointer++;
        contador_Preguntas = question_pointer;
        pregunta = preguntas_basicas[question_pointer];
        opcion1 = opciones[question_pointer][0];
        opcion2 = opciones[question_pointer][1];
        opcion3 = opciones[question_pointer][2];
        opcion4 = opciones[question_pointer][3];
        puntuaje = (score * 2).toString();
      }
    });
  }

  void contestoA() {
    esCorrecto(
        opciones[question_pointer][0], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  void contestoB() {
    esCorrecto(
        opciones[question_pointer][1], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  void contestoC() {
    esCorrecto(
        opciones[question_pointer][2], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  void contestoD() {
    esCorrecto(
        opciones[question_pointer][3], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: barraInformativa(titulo: 'Tel-Soluciones')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 100, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('pregunta $contador_Preguntas de 5',style: TextStyle(fontSize: 35),),
                  )),
              Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      pregunta,
                      style: TextStyle(fontSize: 35),
                    ),
                  )),
              Wrap(
                children: [
                  Container(
                      height: 150,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: contestoA,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: Text(
                              opcion1,
                              style: const TextStyle(color: Colors.white,fontSize: 20),
                            )),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 150,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: contestoB,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: Text(
                              opcion2,
                              style: const TextStyle(color: Colors.white,fontSize: 20),
                            )),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 150,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: contestoC,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: Text(
                              opcion3,
                              style: const TextStyle(color: Colors.white,fontSize: 20),
                            )),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 150,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: contestoD,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: Text(
                              opcion4,
                              style: const TextStyle(color: Colors.white,fontSize: 20),
                            )),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void esCorrecto(String respuesta, respuestacorrecta) {
  if (respuesta == respuestacorrecta) {
    score = score + 10;
  }
}

void resetearexamen() {
  question_pointer = 1;
  finalscore = score;
  score = 0;
}
