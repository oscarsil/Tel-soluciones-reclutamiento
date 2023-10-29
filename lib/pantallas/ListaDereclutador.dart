import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/CrearReclutador.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';

class ListaDeReclutadores extends StatelessWidget{
  const ListaDeReclutadores({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: barraRegSal(titulo: 'Jefe de Reclutamiento')),
        body: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blueAccent,
                    child: barraslaterales(),
                  ),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CrearReclutador()));
                                  },
                                  child: Text('Nuevo reclutador',
                                      style: TextStyle(color: Colors.white))),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () => {},
                                  child: Text('Actualizar reclutador',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          )
                        ],
                      )),
                )
              ],
            )
        ));
  }

  final List<Map> _reclutadores =const [
    {
      'id':100,
      'Nombre':'Mariana',
      'Habilitado':true
    },
    {
      'id':101,
      'Nombre':'Judith',
      'Habilitado':false
    },
    {
      'id':102,
      'Nombre':'Angelica',
      'Habilitado':true
    }];

  DataTable createDataTable(){
    return DataTable(columns: createcolumns(), rows: createRows(),
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange),
      headingTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),);
  }

  List<DataColumn> createcolumns(){
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Nombre')),
      DataColumn(label: Text('Habilitado')),
    ];
  }
  List<DataRow> createRows(){
    return _reclutadores
        .map((reclutador) => DataRow(cells: [
      DataCell(Text(reclutador['id'].toString())),
      DataCell(Text(reclutador['Nombre'])),
      DataCell(Text(reclutador['Habilitado'].toString()))
    ])).toList();
  }
}