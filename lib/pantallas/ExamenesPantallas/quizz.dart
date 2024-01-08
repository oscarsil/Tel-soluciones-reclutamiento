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
  '',];

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
  ['CTRL C','CTRL V','SHIFT C','TAB'],
  ['TAB','F2','CTRL +','CTRL Z'],
  ['googlecom','www.google.com','google-com','google'],
  ['F5','ALT 4','F9','CTRL R'],
  ['F6','DELETE','CTRL V','Caps lock'],
  [],
];


class quizz extends StatefulWidget{
  final int prospecto_int;
  quizz({required this.prospecto_int});
  @override
  State<quizz> createState() => _quizzState();
}

var question_pointer = 1;
int score = 0;
int finalscore = 0;

class _quizzState extends State<quizz>{
  int contador_Preguntas = question_pointer;
  String pregunta = preguntas_basicas[question_pointer];
  String opcion1 =opciones[question_pointer][0];
  String opcion2 =opciones[question_pointer][1];
  String opcion3 =opciones[question_pointer][2];
  String opcion4 =opciones[question_pointer][3];
  String puntuaje = '0';

  void actualizarPregunta(){
    setState(() {
      if(question_pointer ==5 ){
        puntuaje='0';
        resetearexamen();
        print(this.widget.prospecto_int.toString()+" "+(2*finalscore).toString());
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  instruccionesExamenTeclado(prospecto_id: this.widget.prospecto_int,quizzscore: finalscore*2,)
            )
        );
      }else {
        question_pointer ++;
        contador_Preguntas = question_pointer;
        pregunta = preguntas_basicas[question_pointer];
        opcion1 = opciones[question_pointer][0];
        opcion2 = opciones[question_pointer][1];
        opcion3 = opciones[question_pointer][2];
        opcion4 = opciones[question_pointer][3];
        puntuaje = (score*2).toString();
      }
    });
  }

  void contestoA(){
    esCorrecto(opciones[question_pointer][0], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  void contestoB(){
    esCorrecto(opciones[question_pointer][1], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  void contestoC(){
    esCorrecto(opciones[question_pointer][2], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  void contestoD(){
    esCorrecto(opciones[question_pointer][3], respuestas_basicas[question_pointer]);
    actualizarPregunta();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),child:barraInformativa(titulo:'Tel-Soluciones')),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('pregunta $contador_Preguntas de 5'),
            SizedBox(height: 10,),
            Text(pregunta),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: contestoA, style:ElevatedButton.styleFrom(backgroundColor: Colors.orange) ,child: Text(opcion1, style: TextStyle(color: Colors.white),)),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: contestoB ,style: ElevatedButton.styleFrom(backgroundColor: Colors.orange) ,child: Text(opcion2, style: TextStyle(color: Colors.white),)),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: contestoC , style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),child: Text(opcion3, style: TextStyle(color: Colors.white),)),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: contestoD, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),child: Text(opcion4, style: TextStyle(color: Colors.white),)),
            SizedBox(height: 10,),
            Text('Puntuaje: $puntuaje'),
          ],
        ),
      ),
    );
  }
}

void esCorrecto(String respuesta, respuestacorrecta){
  if(respuesta == respuestacorrecta){
    score = score+10;
  }
}


void resetearexamen(){
  question_pointer = 1;
  finalscore=score;
  score = 0;
}
