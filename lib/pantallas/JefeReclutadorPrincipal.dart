import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';

class JefeReclutadorPrincipal extends StatelessWidget{
  const JefeReclutadorPrincipal({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: barraSalir(titulo: 'Jefe de Reclutamiento')),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: barraslaterales(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: createDataTable()
                          ))
                        ],
                      ),
                      IconButton(onPressed: () => {}, icon: Icon(Icons.refresh, color: Colors.black,size: 50,))
                    ],
                  )
              ),
            )
          ],
        ));
  }

  DataTable createDataTable(){
    return DataTable(columns: createcolumns(), rows: createRows(),
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange),
      headingTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),);
  }

  List<DataColumn> createcolumns(){
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Nombre')),
      DataColumn(label: Text('Fecha')),
      DataColumn(label: Text('Resultados')),
      DataColumn(label: Text('Estatus')),
      DataColumn(label: Text('Motivo')),
    ];
  }
  List<DataRow> createRows(){
    return _prospectos
        .map((prospecto) => DataRow(cells: [
      DataCell(Text(prospecto['id'].toString())),
      DataCell(Text(prospecto['Nombre'])),
      DataCell(Text(prospecto['Fecha'].toString())),
      DataCell(Text(prospecto['resultados'].toString())),
      DataCell(Text(prospecto['estatus'])),
      DataCell(Text(prospecto['motivo'].toString())),
    ])).toList();
  }

  final List<Map> _prospectos = const [
    {
      'id': 100,
      'Nombre': 'Juan Vazquez',
      'Fecha':'09/03/2023',
      'resultados': '100% 80% 33 WPM',
      'estatus': 'Contrato pendiente',
      'motivo': ''
    },
    {
      'id': 101,
      'Nombre': 'Mario Gomez',
      'Fecha':'03/02/2023',
      'resultados': '90% 100% 45 WPM',
      'estatus': 'Contrato pendiente',
      'motivo': 'esperando entrevista personal'
    },
    {
      'id': 103,
      'Nombre': 'Ricardo Cruz',
      'Fecha':'18/05/2023',
      'resultados': '70% 90% 40 WPM',
      'estatus': 'Contrato pendiente',
      'motivo': 'capacitacion pendiente'
    }
  ];
}