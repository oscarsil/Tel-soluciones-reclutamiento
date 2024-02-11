import 'package:telsolreclutamiento/pantallas/inicioPantallas/inicio.dart';
import 'package:flutter/material.dart';

class IdProspecto extends StatefulWidget{
  final int? Id;
  const IdProspecto({required this.Id});
  @override
  State<IdProspecto> createState() => _IdProspectoState();
}

class _IdProspectoState extends State<IdProspecto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ID Prospecto"),),
      body: Center(
        child: Column(
          children: [
            Text("A continuacion su ID con el que va usar para iniciar las pruebas"),
            Text(widget.Id.toString()),
            ElevatedButton(
                onPressed:() { Navigator.push(context, MaterialPageRoute(builder: (context) => Inicio()));},
                child: Text("volver a inicio"))
          ],
        ),
      ),
    );
  }
}