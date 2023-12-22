import 'package:flutter/material.dart';
import 'dart:async';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/resultados.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/instruccionesExamAudio.dart';

class examenTeclado extends StatefulWidget{
  final int prospect_id;
  final int quizzscore;
  examenTeclado({required this.prospect_id,required this.quizzscore});
  @override
  State<examenTeclado> createState() => _examenTeclado();
}

class _examenTeclado extends State<examenTeclado>{
  double sacarWpm(int letras, int segundos) {
    double palabras = letras / 5;
    double resultado = (palabras / segundos) * 60;
    return resultado;
  }


  @override
  Widget build(BuildContext context){
    setString();
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),child:barraInformativa(titulo:'Examen de Teclado')),
      body:   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
                ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),onPressed: botonIniciar, child: const Text("Iniciar",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),)),
            Spacer(),
            ElevatedButton(style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),onPressed: botonReiniciar, child: const Text("Reiniciar",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25))),
            ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text("RELOJ"),
        Text(_resultado_Tiempo,style: const TextStyle(fontSize: 50.0),),
        const SizedBox(
          height: 20,
        ),
        const Text("Texto de examen"),
        Container(
          width: 500,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child:Wrap( children: <Widget>[
                Text(textoPasado,style: const TextStyle(color:Colors.green),),
                Text(letraActual+textoFaltante),
              ],)
          ),
        const SizedBox(
          height: 20,
        ),
        examenEmpezado == true ? SizedBox(
            width: 400,
            child: TextField(
          controller: _textFieldController, // Asigna el controlador al TextField
          onChanged: (text) {
            setState(() {
              if(compareLetters(text)){
                if(textpointer==exam.length){
                  tiempofinal = _stopwatch.elapsed.inSeconds;
                  _stop();
                  _textFieldController.clear();
                  Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) =>  Resultados(time: tiempofinal, length: exam.length, errors: errores,)));
                      MaterialPageRoute(builder: (context) => instruccionesExamenAuditivo(prospecto_id: 100, quizzscore: 100, tecladoscore: sacarWpm(exam.length, tiempofinal),)));
                }
                else{
                  textpointer++;
                  _textFieldController.clear();
                  errorText = '';

                }
              }else{
                errores++;
                errorText = '$text es incorrecto. Corrige.';
                _textFieldController.clear();
              }

            });
          },
          decoration: const InputDecoration(labelText: 'Ingresa el texto aquí',/* hintText: 'Texto',*/),
        ) ): const Text('Pulsa el boton de inicio para empezar, despues en el cuadro de texto, empieza a teclear'),
        Text(
          errorText,
          style: const TextStyle(color: Colors.red), // Estilo del mensaje de error
        ),
      ],
    ),
    );

  }
  String exam = "Para poder establecer una comunicacion a "
      "distancia mediante telefono hace falta la "
      "activacion de un determinado servicio en la red telefonica. "
      "Los costes resultantes son facturados al cliente "
      "del telefono por parte de las companias telefonicas.";
  int textpointer = 1;
  String textoPasado = '';
  String letraActual = '';
  String textoFaltante = '';
  int errores = 0;
  String errorText="";
  final _textFieldController = TextEditingController();// Controlador para el TextField

  void botonIniciar(){
    examenEmpezado = true;
    if(_resultado_Tiempo == '00:00:00'){
      startExam();
    }
  }

  void botonReiniciar(){
    if(examenEmpezado){
      examenEmpezado = false;
    }
    if(_resultado_Tiempo != '00:00:00'){
      _stop();
      _stopwatch.reset();
      _resultado_Tiempo = '00:00:00';
    }
    resetText();
  }


  int tiempofinal = 0;


  void setString() {
    if(textpointer>exam.length){
      examenTerminado=true;
      if(_resultado_Tiempo != '00:00:00'){
        _stop();
      }
      return;
    }
    textoPasado = exam.substring(0, textpointer - 1);
    letraActual = exam.substring(textpointer - 1, textpointer);
    textoFaltante = exam.substring(textpointer);
  }
  void resetText() {
    setState(() {
      textpointer = 1;
      setString();
    });
    errores=0;
    // Limpia el contenido del TextField
  }
  void startExam() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {
        _resultado_Tiempo =
        '${_stopwatch.elapsed.inMinutes.toString().padLeft(2,
            '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2,
            '0')}:${(_stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
    // Empezar timer
  }

  void _stop(){
    _timer.cancel();
    _stopwatch.stop();
  }


  bool compareLetters(String textoIngresado) {
    if (textoIngresado==letraActual){
      return true;
    }
    else{
      return false;
    }
    // Comparar letras
  }

  final Stopwatch _stopwatch = Stopwatch();

  late Timer _timer;

  String _resultado_Tiempo = '00:00:00';

  bool examenTerminado = false;
  bool examenEmpezado = false;
}