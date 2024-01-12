import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/quizz.dart';

class DashboardReclutador extends StatefulWidget{
  const DashboardReclutador({super.key});

  @override
  State<DashboardReclutador> createState() => _DashboardReclutadorState();
}

class _DashboardReclutadorState extends State<DashboardReclutador> {
  @override
  void dispose(){
    _textID.dispose();
    super.dispose();
  }

  final _textID = TextEditingController();

  bool isError = false;
  String error = '';
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: barraSalir(titulo: 'Reclutador')),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueAccent,
                child: barraRelcutador(),
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
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _textID,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: ()  {
                            setState(() {
                              if(_textID.text.isEmpty){
                                isError = true;
                                error = 'favor de llenar campo';
                              }else{
                                isError = false;
                                error = '';
                                print(_textID.text);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => quizz(prospecto_int: int.parse(_textID.text))));
                              }
                            });
                          }, child: Text('Iniciar Proceso', style: TextStyle(color: Colors.white),)),
                          Container(
                            child: isError ? Text(error) :  null),
                        ],
                      )
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
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