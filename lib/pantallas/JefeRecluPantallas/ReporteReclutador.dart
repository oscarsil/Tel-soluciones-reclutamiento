import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/Reporte.dart';

class ReporteReclutador extends StatefulWidget{
  @override
  State<ReporteReclutador> createState() => _ReporteReclutador();
}

class _ReporteReclutador extends State<ReporteReclutador>{

  DateTime _dateTimeDesde = DateTime.now();
  DateTime _dateTimeHasta = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  _showDatePickerDesde(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030))
        .then((value){
      setState(() {
        _dateTimeDesde = value!;
      });
    });
  }

  _showDatePickerHasta(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        _dateTimeHasta = value!;
      });
    });
  }

  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize:  Size.fromHeight(50),
          child: barraSalir(titulo: 'Reporte de Reclutador',)),
      body: Center(
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blueAccent,
                  child: barraslaterales(),
                )),
            Expanded(
                flex: 13,
                child: Container(
                  color: Colors.white,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.calendar_month),
                          Text(formatter.format(_dateTimeDesde)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                              onPressed: () {
                            _showDatePickerDesde();
                          }, child: const Text("Desde", style: TextStyle(color: Colors.white))),
                          const Icon(Icons.calendar_month),
                          Text(formatter.format(_dateTimeHasta)),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                              onPressed: () {
                            _showDatePickerHasta();
                          }, child: const Text("Hasta", style: TextStyle(color: Colors.white))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                              onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Reporte(desde: formatter.format(_dateTimeDesde), hasta: formatter.format(_dateTimeHasta)) ));
                          }, child: const Text("Buscar", style: TextStyle(color: Colors.white)))
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

}