import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/JefeReclutadorPrincipal.dart';


class IniciarSession extends StatelessWidget{
  const IniciarSession({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: barraInformativa(titulo: 'Tel-Soluciones')),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: 10),
                Text("Nombre de Usuario"),
                SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),),
                SizedBox(height: 10),
                Text("Contraseña"),
                SizedBox(height: 10),
                SizedBox(
                    width: 400,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => JefeReclutadorPrincipal()));
                    },
                    child: const Text('Log-in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 25),))
              ],
            )),
      ),
    );
  }
}