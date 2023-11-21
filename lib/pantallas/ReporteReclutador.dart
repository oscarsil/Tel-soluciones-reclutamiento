import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/componentes/barraslaterales.dart';

class ReporteReclutador extends StatefulWidget{
  @override
  State<ReporteReclutador> createState() => _ReporteReclutador();
}

class _ReporteReclutador extends State<ReporteReclutador>{

  TextEditingController ValorDesde = TextEditingController();
  TextEditingController ValorHasta = TextEditingController();

  @override
  void initState(){
    ValorDesde.text = "";
    ValorHasta.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
          child: barraRegSal(titulo: 'Reporte de Reclutador',), 
          preferredSize: const Size.fromHeight(50)),
      body: Center(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blueAccent,
                  child: barraslaterales(),
                )),
            Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopTableRow(),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: createDataTable(),
                              )
                          )
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

  final List<Map> _Reclutadoras = const [
    {
      'id': 100,
      'Nombre': 'Yudith Garcia',
      'Entrevistados':'15',
    },
    {
      'id': 101,
      'Nombre': 'Mariana Paz',
      'Entrevistados':'15',
    },
  ];

  DataTable createDataTable(){
    return DataTable(
        columns: createcolumns(),
        rows: createRows(),
        headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange),
        headingTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
    );
  }

  List<DataColumn> createcolumns(){
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Nombre')),
      DataColumn(label: Text('Entrevistados')),
    ];
  }

  List<DataRow> createRows(){
    return _Reclutadoras
        .map((Reclutador) => DataRow(cells: [
          DataCell(Text(Reclutador['id'].toString())),
          DataCell(Text(Reclutador['Nombre'])),
          DataCell(Text(Reclutador['Entrevistados'].toString())),
    ])).toList();
  }

  Row TopTableRow(){
    return Row(
      children: [
        SizedBox(width: 10,),
        Container(
            width: 150,
            child: calendarioDesde()
        ),
        SizedBox(width: 20,),
        Container(
          width: 150,
          child: calendarioaHasta(),
        ),
        SizedBox(width: 100,),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: () => {}, child: Text('Generar', style: TextStyle(color: Colors.white),))
      ],
    );
  }

  TextField calendarioDesde(){
    return TextField(
      controller: ValorDesde,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.calendar_today),
        labelText: "Desde"
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context, initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2050)
        );
        if(pickedDate != null){
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            ValorDesde.text  = formattedDate;
          });
        }
      },
    );
  }

  TextField calendarioaHasta(){
    return TextField(
      controller: ValorHasta,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_today),
          labelText: "Hasta"
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context, initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2050)
        );
        if(pickedDate != null){
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            ValorHasta.text  = formattedDate;
          });
        }
      },
    );
  }

}