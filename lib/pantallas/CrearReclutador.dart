import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ListaDereclutador.dart';

class CrearReclutador extends StatelessWidget {
  const CrearReclutador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
          child: barraRegSal(titulo: 'Crear Reclutador')),
      body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Nuevo Reclutador', style: TextStyle(fontSize: 25),),
              SizedBox(height: 20),
              Text('Nombre Complete'),
              SizedBox(height: 15,),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Introduzca el nombre completo',
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text('Contraseña'),
              SizedBox(height: 15,),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      hintText: 'Introduzca contraseña'
                  ),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListaDeReclutadores()));
                  },
                  child: Text('Crear', style: TextStyle(color: Colors.white),)
              )
            ],
          )
      ),
    );
  }
}