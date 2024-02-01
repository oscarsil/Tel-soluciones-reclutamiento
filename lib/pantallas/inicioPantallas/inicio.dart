import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ProspectoPantallas/FormularioProspecto.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/examenes.dart';

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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.fromLTRB(180, 30, 180, 30),
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
