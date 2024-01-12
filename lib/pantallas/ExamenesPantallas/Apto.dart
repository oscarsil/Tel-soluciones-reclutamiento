import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/DashboardReclutador.dart';

class apto extends StatefulWidget{
  final int prospecto_id;
  final int quizzscore;
  final double tecladoscore;
  final double auditivoscore;
  apto({required this.prospecto_id,required this.quizzscore,required this.tecladoscore, required this.auditivoscore});
  @override
  State<apto> createState() => _aptoState();
}

class _aptoState extends State<apto> {

  double puntuajefinall = 0;


  double wpmtograde(double wpm){
    if(wpm >= 45){
      return 100;
    }else{
      return (wpm*100)/45;
    }
  }

  double finalgrade(int quizz, double wpm, double audio){
    puntuajefinall = (quizz + wpm + audio)/3;
    return (quizz + wpm + audio)/3;
  }

  String VarificarApto(double finalgrade){
    if(finalgrade>=70){
      return 'Apto';
    }else{
      return 'No es Apto';
    }
  }
  String pruebaresultados = '';
  String stringPrueba(){
    return 'Prospecto id: '+this.widget.prospecto_id.toString()+' Calificacion de quizz: '
        +this.widget.quizzscore.toString()+' PPM: '+this.widget.tecladoscore.toString()+
        ' Calificacion de examen de Teclado: '+wpmtograde(this.widget.tecladoscore).toString()+
        ' Calificacion de examen auditivo: '+this.widget.auditivoscore.toString()+
        ' Promedio '+finalgrade(this.widget.quizzscore, wpmtograde(this.widget.tecladoscore), this.widget.auditivoscore).toStringAsFixed(2)
        +' Apto o No Apto: '+VarificarApto(puntuajefinall);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),child: barraInformativa(titulo: 'resultados',)),
      body: Center(
        child: Column(
          children: [
            Text("Examen terminado"),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  print(stringPrueba());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardReclutador()));
                },
                child: Text("Volver a pagina principal", style: TextStyle(color: Colors.white, fontSize: 20),)),
          ],
        ),
      ),
    );
  }
}

//double.parse(resultadofinal.toStringAsFixed(2)