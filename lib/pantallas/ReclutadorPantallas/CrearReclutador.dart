import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';

class CrearReclutador extends StatefulWidget {

  const CrearReclutador({super.key});

  @override
  State<CrearReclutador> createState() => _CrearReclutadorState();
}

class _CrearReclutadorState extends State<CrearReclutador> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
          child: barraRegSal(titulo: 'Crear Reclutador')),
      body: Form(
        key: formKey,
        child: Center(
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
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "nombre Requerido";
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "contraseña Requerido";
                      }
                      return null;
                    },
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
                      if(formKey.currentState!.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListaDeReclutadores()));
                      }
                    },
                    child: Text('Crear', style: TextStyle(color: Colors.white),)
                )
              ],
            )
        ),
      ),
    );
  }
}