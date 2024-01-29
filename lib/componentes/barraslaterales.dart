import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/JefeReclutadorPrincipal.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/ReporteReclutador.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/borrarReclu.dart';
import 'package:telsolreclutamiento/pantallas/ProspectoPantallas/BorrarProspecto.dart';

class barraslaterales extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height
        ),
        color: Colors.blueAccent,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 55,
            ),
            IconButton(onPressed: ()  {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ListaDeReclutadores()));
            }, icon: const Icon(Icons.account_circle, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('Reclutador',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
            const SizedBox(height: 50,),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const JefeReclutadorPrincipal()));
            }, icon: const Icon(Icons.account_circle, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('Reporte de prospectos',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
            const SizedBox(height: 50,),
            IconButton(onPressed: ()  {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReporteReclutador()));
            }, icon: const Icon(Icons.feed, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('Reporte de Reclutador',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
            const SizedBox(height: 50,),
            IconButton(onPressed: ()  {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const borrarReclu()));
            }, icon: const Icon(Icons.remove_circle, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('Borrar Reclutador',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
            const SizedBox(height: 50,),
            IconButton(onPressed: ()  {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const borrarProspecto()));
            }, icon: const Icon(Icons.remove_circle, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('Borrar Prospecto',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
          ],
        ),
      ),
    );
  }
}

class barraRelcutador extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const SizedBox(height: 50,),
        IconButton(onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardReclutador()));
        }, icon: const Icon(Icons.feed, color: Colors.white,size: 50,)),
        const SizedBox(height: 10,),
        const Wrap(children: [Text('Reporte de prospectos',style: TextStyle(fontSize: 18, color: Colors.white),)],),
        const SizedBox(height: 50,),
        IconButton(onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const borrarProspecto()));
        }, icon: const Icon(Icons.remove_circle, color: Colors.white,size: 50,)),
        const SizedBox(height: 10,),
        const Wrap(children: [Text('Borrar prospectos',style: TextStyle(fontSize: 18, color: Colors.white),)],),
      ],
    );
  }
}