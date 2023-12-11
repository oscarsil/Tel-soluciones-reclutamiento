import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/pantallas/DashboardReclutador.dart';
import 'package:telsolreclutamiento/pantallas/ListaDereclutador.dart';
import 'package:telsolreclutamiento/pantallas/JefeReclutadorPrincipal.dart';
import 'package:telsolreclutamiento/pantallas/EditarProspecto.dart';
import 'package:telsolreclutamiento/pantallas/ReporteReclutador.dart';

class barraslaterales extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditarProspecto()));
          }, icon: Icon(Icons.edit_square, color: Colors.white,size: 50,)),
          SizedBox(height: 10,),
          Wrap(children: [Text('Editar info de prospecto',style: TextStyle(fontSize: 18, color: Colors.white),)],),
          SizedBox(height: 50,),
          IconButton(onPressed: ()  {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListaDeReclutadores()));
          }, icon: Icon(Icons.account_circle, color: Colors.white,size: 50,)),
          SizedBox(height: 10,),
          Wrap(children: [Text('Reclutador',style: TextStyle(fontSize: 18, color: Colors.white),)],),
          SizedBox(height: 50,),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => JefeReclutadorPrincipal()));
          }, icon: Icon(Icons.account_circle, color: Colors.white,size: 50,)),
          SizedBox(height: 10,),
          Wrap(children: [Text('Reporte de prospectos',style: TextStyle(fontSize: 18, color: Colors.white),)],),
          SizedBox(height: 50,),
          IconButton(onPressed: ()  {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReporteReclutador()));
          }, icon: Icon(Icons.feed, color: Colors.white,size: 50,)),
          SizedBox(height: 10,),
          Wrap(children: [Text('Reporte de Reclutador',style: TextStyle(fontSize: 18, color: Colors.white),)],),
        ],
      ),
    );
  }
}

class barraRelcutador extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditarProspecto()));
        }, icon: Icon(Icons.edit_square, color: Colors.white,size: 50,)),
        SizedBox(height: 10,),
        Wrap(children: [Text('Editar info de prospecto',style: TextStyle(fontSize: 18, color: Colors.white),)],),
        SizedBox(height: 50,),
        IconButton(onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardReclutador()));
        }, icon: Icon(Icons.feed, color: Colors.white,size: 50,)),
        SizedBox(height: 10,),
        Wrap(children: [Text('Reporte de prospectos',style: TextStyle(fontSize: 18, color: Colors.white),)],),
      ],
    );
  }
}