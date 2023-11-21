import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/pantallas/JefeReclutadorPrincipal.dart';

final _textid = TextEditingController();
final _textNombre = TextEditingController();
final _textAP = TextEditingController();
final _textAM = TextEditingController();
final _textEdad = TextEditingController();
final _textSexo = TextEditingController();
final _textTelefono = TextEditingController();
final _textEscolaridad = TextEditingController();
final _textestatus = TextEditingController();
final _textMotivo = TextEditingController();


class EditarProspecto extends StatefulWidget{
  @override
  State<EditarProspecto> createState() => _EditarProspecto();
}

class _EditarProspecto extends State<EditarProspecto>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  PreferredSize(child: barraRegSal(titulo: 'Editar Prospecto',), preferredSize: Size.fromHeight(50)),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
            Expanded(
              flex: 5,
                child: Container(
                    alignment: Alignment.topCenter,
                    child:
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Buscar por ID'),
                            SizedBox(width: 20,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: _textid,
                              ),
                            ),
                            SizedBox(width: 20,),
                            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: () => {}, child: Text('Buscar', style: TextStyle(color: Colors.white),))
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      campos(),
                    ],
                  ),
                )
                )
            )
          ],
        ),
      ),
    );
  }
}


class campos extends StatefulWidget {
  @override
  State<campos> createState() => _campos();
}

class _campos extends State<campos>{
  String dropdownvalueReclu = 'Reclutadora';

  String dropdownvalueCamp = 'Agente R02';

  var campanas = ['Agente R02','Agente R03','Renovaciones','Admin'];


  var reclutadoras = [
    'Reclutadora',
    'Yudith Garcia',
    'Mariana Paz',
    'Angelica flores',
  ];

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textNombre,
                decoration: InputDecoration(
                  labelText: 'Nombre(s)',
                ),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textAP,
                decoration: InputDecoration(
                  labelText: 'Apellido Paterno'
                ),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textAM,
                decoration: InputDecoration(
                  labelText: 'Apellido Materno'
                ),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 80,
              child: TextField(
                controller: _textEdad,
                decoration: InputDecoration(
                  labelText: 'Edad',),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 80,
              child: TextField(
                controller: _textSexo,
                decoration: InputDecoration(
                  labelText: 'Sexo'
                ),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textTelefono,
                decoration: InputDecoration(
                  labelText: 'Telefono'
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textEscolaridad,
                decoration: InputDecoration(
                  labelText: 'Escolaridad'
                ),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              child: DropdownButton(
                value: dropdownvalueCamp,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: campanas.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalueCamp = newValue!;
                  });
              },
              ),
            ),
            SizedBox(width: 10,),
            Container(
              child: DropdownButton(
                value: dropdownvalueReclu,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: reclutadoras.map((String items){
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    dropdownvalueReclu = newValue!;
                  });
                },
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textestatus,
                decoration: InputDecoration(
                  labelText: 'Estatus'
                ),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 200,
              height: 400,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _textMotivo,
                decoration: InputDecoration(
                  labelText: 'Motivo'
                ),
              ),
            )
          ],
        ),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context) => JefeReclutadorPrincipal()));
        }, child: Text('Guardar', style: TextStyle(color: Colors.white),))
      ],
    );
  }
}