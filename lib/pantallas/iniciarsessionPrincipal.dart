import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/pantallas/iniciarSession.dart';
import 'package:telsolreclutamiento/pantallas/iniciarsessionReclutador.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';

class iniciarsessionprinicipal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: barraInformativa(titulo: 'Tel-Soluciones')),
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
                      padding: const EdgeInsets.fromLTRB(90, 15, 90, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IniciarSession()),
                    );
                  },
                  child: const Text(
                    'Jefe De Reclutamiento',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )),
              SizedBox(height: 25,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.fromLTRB(90, 15, 90, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))
                  ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => iniciarsessionReclutador()),
                );
              }, child: const Text(
                'Reclutador',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              )),
            ],
          ),
        ),
      ),
    );
  }

}