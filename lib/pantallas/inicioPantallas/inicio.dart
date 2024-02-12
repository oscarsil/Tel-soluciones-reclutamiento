import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/inicioPantallas/FormularioProspecto.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/examenes.dart';
import 'package:telsolreclutamiento/pantallas/inicioPantallas/ElegirReclutador.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize:  Size.fromHeight(50),
          child: barraIniciarSession(titulo: 'Tel-Soluciones')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                width: 250,
                height: 250,
                child: Image.asset(
                  "assets/images/logo-Tel-soluciones.png",
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.fromLTRB(150, 30, 150, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormularioProspecto()),
                          );
                        },
                        child: const Text(
                          '    Nuevo\nProspecto',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 25),
                        )),
                    SizedBox(width: 20,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.fromLTRB(110, 30, 110, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ElegirReclu())
                      );
                    } , child: const Text("Iniciar Aplicacion \n de examen",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25),))
                  ],
                ),
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => examenes()),
                );
              }, child: const Text(
                'Examenes',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
