import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';
import 'package:telsolreclutamiento/database_helper.dart';

class CrearReclutador extends StatefulWidget {

  const CrearReclutador({super.key});

  @override
  State<CrearReclutador> createState() => _CrearReclutadorState();
}

class _CrearReclutadorState extends State<CrearReclutador> {

  final Nombre = TextEditingController();
  final contra = TextEditingController();

  final db = database_helper();


  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crear Reclutador",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: formKey,
        child: Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Nuevo Reclutador', style: TextStyle(fontSize: 25),),
                const SizedBox(height: 20),
                const Text('Nombre Complete'),
                const SizedBox(height: 15,),
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: Nombre,
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
                const SizedBox(height: 30,),
                const Text('Contraseña'),
                const SizedBox(height: 15,),
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: contra,
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
                const SizedBox(height: 40,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        db.crearReclutador(Reclutador(
                            username: Nombre.text,
                            password: contra.text,
                            habilitado: 1)).whenComplete(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ListaDeReclutadores()));
                        });
                      }
                    },
                    child: const Text('Crear', style: TextStyle(color: Colors.white),)
                )
              ],
            )
        ),
      ),
    );
  }
}