import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/pantallas/inicio.dart';
import 'package:telsolreclutamiento/pantallas/iniciarSession.dart';

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
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
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
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IniciarSession()),
              );
            },
            child: const Text(
              'Iniciar session',
              style: TextStyle(color: Colors.white),
            ))
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
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {}, icon: Image.asset('assets/images/exit.png'))
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
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {}, icon: Image.asset('assets/images/regresar.png')),
        IconButton(
            onPressed: () {}, icon: Image.asset('assets/images/exit.png'))
      ],
      backgroundColor: Colors.blueAccent,
    );
  }
}

//PreferredSize(preferredSize: const Size.fromHeight(50),child:barraApp()),
