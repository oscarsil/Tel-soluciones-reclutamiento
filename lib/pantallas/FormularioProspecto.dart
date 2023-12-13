import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:flutter/services.dart';
import 'dart:math';

bool formularioLlenado = false;
bool FaltaLlenarCampo = false;

class FormularioProspecto extends StatefulWidget {
  @override
  State<FormularioProspecto> createState() => _FormularioProspecto();
}

class _FormularioProspecto extends State<FormularioProspecto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: barraRegresar(titulo: 'Por Favor de Introducir Datos')),
      body: Center(
        child: Column(
          children: [
            campos(),
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

class _campos extends State<campos> {

  bool validarBoton(String vn, vap, vam, ved,vs,vt,ves){
    if(vn == '' || vap== '' || vam== '' || ved== '' ||  vs== '' || vt== '' || ves== ''){
      FaltaLlenarCampo = true;
      return false;
    }else{
      FaltaLlenarCampo = false;
      return true;
    }
  }

  String dropdownvalueReclu = 'Reclutadora';

  String dropdownvalueCamp = 'Agente R02';

  var campanas = ['Agente R02','Agente R03','Renovaciones','Admin'];


  var reclutadoras = [
    'Reclutadora',
    'Yudith Garcia',
    'Mariana Paz',
    'Angelica flores',
  ];

   final _textNombre = TextEditingController();
  final _textAp = TextEditingController();
  final _textAm = TextEditingController();
  final _textEdad = TextEditingController();
  final _textSexo = TextEditingController();
  final _textTelefono = TextEditingController();
  final _textEsc = TextEditingController();


  @override
  void dispose(){
    _textNombre.dispose();
    _textAp.dispose();
    _textAm.dispose();
    _textEdad.dispose();
    _textSexo.dispose();
    _textTelefono.dispose();
    _textEsc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                )),
            SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _textAp,
                  decoration: InputDecoration(
                      labelText: 'Apellido Paterno',
                  ),
                )),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _textAm,
                  decoration: InputDecoration(
                      labelText: 'Apellido Materno',
                  ),
                )),
            SizedBox(
              width: 10,
            ),
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
                )),
            SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 80,
                child: TextField(
                  controller: _textSexo,
                  decoration: InputDecoration(
                      labelText: 'Sexo',
                  ),
                )),
            SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _textTelefono,
                  decoration: InputDecoration(
                      labelText: 'Telefono',),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )),
            SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _textEsc,
                  decoration: InputDecoration(
                      labelText: 'Escolaridad',),
                )),
            SizedBox(
              width: 10,
            ),
            Container(
              child: DropdownButton(
                // Initial Value
                value: dropdownvalueReclu,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: reclutadoras.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalueReclu = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
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
                onChanged: (String? newValue){
                  setState(() {
                    dropdownvalueCamp = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
        ElevatedButton(onPressed: () {
          setState(() {
            if(validarBoton(_textNombre.text, _textAp.text, _textAm.text, _textEdad.text, _textSexo.text,_textTelefono.text, _textEsc.text)){
              createprospect( _textNombre.text, _textAp.text, _textAm.text, _textEdad.text,
                  _textSexo.text, _textTelefono.text, _textEsc.text, dropdownvalueReclu,dropdownvalueCamp);
              formularioLlenado = true;
            }else{
              print('no go');
            }
          });
        }, child: Text('Enviar',style: TextStyle(color: Colors.white, fontSize: 15),), style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),),
        Container(
          child: formularioLlenado ? Text('ID PROCESO: $idGenerado') : null,
        ),
        Container(
          child: FaltaLlenarCampo ? Text('Falta llenar un campo') : null
        )
      ],
    );

  }
}


int idGenerado = 0;
void createprospect(String nombre, apellidopat, apellidomat, edad, sexo, telefono, escolaridad,reclutador,campana){
  idGenerado = generarId();
  print('PROSPECT = {id: $idGenerado,nombre: $nombre'
      'Apellido Paterno: $apellidopat, Apellido Materno: $apellidomat'
      'Edad: $edad, Sexo: $sexo, Telefono: $telefono'
      'Escolaridad: $escolaridad Reclutadora : $reclutador ,Campaña : $campana}');
}

int generarId(){
  Random random = new Random();
  return random.nextInt(100000);
}
