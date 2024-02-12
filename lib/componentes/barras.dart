import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/pantallas/inicioPantallas/iniciarsessionPrincipal.dart';
import 'package:telsolreclutamiento/pantallas/inicioPantallas/inicio.dart';

//cambiar nombre a barras
class barraInformativa extends StatelessWidget {
  final String titulo;
  const barraInformativa({required this.titulo});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset("assets/images/logo-Tel-soluciones.png"),
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}

class barraRegresarMenuPrincipal extends StatelessWidget{
  final String titulo;
  const barraRegresarMenuPrincipal({required this.titulo});
  @override
  Widget build(BuildContext context){
    return AppBar(
      leading: Image.asset("assets/images/logo-Tel-soluciones.png"),
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Inicio()),
          );
        }, child: const Text(
          'Regresar al menu Principal',
          style: TextStyle(color: Colors.white),
        ))
      ],
    );
  }
}

class barraIniciarSession extends StatelessWidget {
  final String titulo;
  const barraIniciarSession({required this.titulo});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset("assets/images/logo-Tel-soluciones.png"),
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  iniciarsessionprinicipal()),
              );
            },
            child: const Text(
              'Iniciar session',
              style: TextStyle(color: Colors.white),
            )
        )
      ],
      backgroundColor: Colors.blueAccent,
    );
  }
}

class barraRegresar extends StatelessWidget {
  final String titulo;
  const barraRegresar({required this.titulo});
  @override
  Widget build(BuildContext context){
    return AppBar(
      leading:Image.asset("assets/images/logo-Tel-soluciones.png") ,
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white,))
      ],
      backgroundColor: Colors.blueAccent,
    );
  }
}

class barraSalir extends StatelessWidget {
  final String titulo;
  const barraSalir({required this.titulo});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset("assets/images/logo-Tel-soluciones.png"),
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Inicio()));
            }, icon: const Icon(Icons.exit_to_app, color: Colors.white,))
      ],
      backgroundColor: Colors.blueAccent,
    );
  }
}

class barraRegSal extends StatelessWidget {
  final String titulo;
  const barraRegSal({required this.titulo});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset("assets/images/logo-Tel-soluciones.png"),
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, icon:   const Icon(Icons.arrow_back, color: Colors.white,)),
        IconButton(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Inicio()));

            }, icon: const Icon(Icons.exit_to_app, color: Colors.white,))
      ],
      backgroundColor: Colors.blueAccent,
    );
  }
}

//PreferredSize(preferredSize: const Size.fromHeight(50),child:barraApp()),
