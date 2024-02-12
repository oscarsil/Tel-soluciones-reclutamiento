import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/RecluElegirProsEditar.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/JefeRecluElegirProsEditar.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ReporteReclutador.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/borrarReclu.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/BorrarProspecto.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/DashboardJefeReclu.dart';

class barraslaterales extends StatelessWidget{
  DateTime _dateTime = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
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
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  DashboardJefe(fecha: formatter.format(_dateTime))));
            }, icon: const Icon(Icons.list_alt_rounded, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('DashBoard',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const JefeRecluElegirProsEditar()));
            }, icon: const Icon(Icons.account_circle, color: Colors.white,size: 50,)),
            const SizedBox(height: 10,),
            const Align(alignment: Alignment.center,child: Wrap(children: [Text('Editar Prospecto',style: TextStyle(fontSize: 18, color: Colors.white),)],)),
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
  DateTime _dateTime = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        const SizedBox(height: 50,),
        IconButton(onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RecluElegirProsEditar()));
        }, icon: const Icon(Icons.edit, color: Colors.white,size: 50,)),
        const SizedBox(height: 10,),
        const Wrap(children: [Text('Editar de prospectos',style: TextStyle(fontSize: 18, color: Colors.white),)],),
        const SizedBox(height: 50,),
        IconButton(onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  DashboardReclu(fecha: formatter.format(_dateTime))));
        }, icon: const Icon(Icons.list_alt_outlined, color: Colors.white,size: 50,)),
        const SizedBox(height: 10,),
        const Wrap(children: [Text('DashBoard',style: TextStyle(fontSize: 18, color: Colors.white),)],),
        //Falta dashboard
      ],
    );
  }
}