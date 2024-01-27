import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/examenTecleo.dart';

class instruccionesExamenTeclado extends StatelessWidget{
  final int prospecto_id;
  final int quizzscore;
  instruccionesExamenTeclado({required this.prospecto_id,required this.quizzscore});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),child:barraInformativa(titulo:'instrucciones para el Examen de Teclear')),
      body: Center(
        child: Column(
          children: [
            Container(width: 750,child: Wrap(children: [Text('favor de dar click en el boton de iniciar, que activara un cuadro de texto que aparecera bajo el cuadro. escribe el texto que aparece en el cuadro de arriba, el texto se pondra de color verde cuando se escriba correctamente y de otra manera este se pondra de color rojo cuando el texto mal ')])),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.fromLTRB(180, 30, 180, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
              print(prospecto_id.toString()+" "+quizzscore.toString());
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => examenTeclado(prospect_id: prospecto_id, quizzscore: quizzscore,)));
            }, child: Text('Comenzar',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 25),))
          ],
        ),
      ),
    );
  }
}