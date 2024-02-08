import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/JefeRecluElegirProsEditar.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/DashboardJefeReclu,dart.dart';
import 'package:telsolreclutamiento/modelos/jefDeReclutamiento.dart';
import 'package:telsolreclutamiento/database_helper.dart';


bool onError= false;


class IniciarSession extends StatefulWidget{


  const IniciarSession({super.key});

  @override
  State<IniciarSession> createState() => _IniciarSessionState();
}

class _IniciarSessionState extends State<IniciarSession> {
  DateTime _dateTime = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  bool isLoginTrue = false;

  final db = database_helper();


  login() async {
    var response = await db.login(JefeDeReclutamiento(username: _textUserName.text, password: _textPassword.text));
    if(response == true){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  DashboardJefe(fecha: formatter.format(_dateTime),)));
    }else{
      onError = true;
      textError = 'usuario o contrasena incorrecto';
    }
  }

  void validar(String username,String password){
    if(username == '' || password ==''){
      onError = true;
      textError = 'falta llenar campos';
    }else{
      onError == false;
      login();
    }
  }

  final _textUserName = TextEditingController();

  final _textPassword = TextEditingController();

  String textError = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: barraRegresar(titulo: 'Tel-Soluciones')),
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
                const SizedBox(height: 10),
                const Text("Jefe De Reclutamiento"),
                const SizedBox(height: 10),
                const Text("Nombre de Usuario"),
                const SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _textUserName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),),
                const SizedBox(height: 10),
                const Text("Contraseña"),
                const SizedBox(height: 10),
                SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _textPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    onPressed: () {
                      setState(() {
                        validar(_textUserName.text, _textPassword.text);
                      });
                    },
                    child: const Text('Log-in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 25),)),
                const SizedBox(height: 10),
                Container(
                  child: onError == true ? Text(textError) : null,
                ),
              ],
            )),
      ),
    );
  }
}