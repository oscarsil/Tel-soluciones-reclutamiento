import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';
import 'package:telsolreclutamiento/database_helper.dart';


bool formularioLlenado = false;
bool FaltaLlenarCampo = false;

final db = database_helper();

class FormularioProspecto extends StatefulWidget {
  @override
  State<FormularioProspecto> createState() => _FormularioProspecto();
}

class _FormularioProspecto extends State<FormularioProspecto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize:  Size.fromHeight(50),
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


  bool _mostrarBoton = true;

  void esconderBoton(){
    setState(() {
      _mostrarBoton = !_mostrarBoton;
    });
  }

  String error='';
  bool isError= false;

  int newid = 0;

  bool validarBoton(String vn, vap, vam, ved, vdir,vt,ves){
    if(vn == '' || vap== '' || vam== '' || vdir=='' || ved== ''  || vt== '' || ves== ''){
      isError = true;
      error = "falta llenar campo";
      return false;
    }else{
      if(vt.length == 10){
        isError = false;
        return true;
      }else{
        isError = true;
        error = "numero de telefono invalido";
        return false;
      }
    }
  }


  String dropdownvalueCamp = 'Agente R02';

  var campanas = ['Agente R02','Agente R03','Renovaciones','Admin','Megacable'];


   final _textNombre = TextEditingController();
  final _textAp = TextEditingController();
  final _textAm = TextEditingController();
  final _textdir = TextEditingController();
  final _textEdad = TextEditingController();
  final _textTelefono = TextEditingController();
  final _textEsc = TextEditingController();


  @override
  void initState(){
    _textNombre.text = '';
    _textAp.text ='';
    _textAm.text='';
    _textdir.text='';
    _textEdad.text='';
    _textTelefono.text='';
    _textEsc.text='';
  }

  void cleartext(){
    _textNombre.clear();
    _textAp.clear();
    _textAm.clear();
    _textdir.clear();
    _textEdad.clear();
    _textTelefono.clear();
    _textEsc.clear();
  }


  @override
  void dispose(){
    _textNombre.dispose();
    _textAp.dispose();
    _textAm.dispose();
    _textdir.dispose();
    _textEdad.dispose();
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ ]"))
                  ],
                  controller: _textNombre,
                  decoration: const InputDecoration(
                      labelText: 'Nombre(s)',
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ ]"))
                  ],
                  controller: _textAp,
                  decoration: const InputDecoration(
                      labelText: 'Apellido Paterno',
                  ),
                )),
            SizedBox(
                width: 300,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ ]"))
                  ],
                  controller: _textAm,
                  decoration: const InputDecoration(
                      labelText: 'Apellido Materno',
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textdir,
                decoration: const InputDecoration(
                  labelText: 'Direccion'
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _textTelefono,
                  decoration: const InputDecoration(
                      labelText: 'Telefono',),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: _textEsc,
                  decoration: const InputDecoration(
                      labelText: 'Escolaridad',),
                )),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 80,
                child: TextField(
                  controller: _textEdad,
                  decoration: const InputDecoration(
                    labelText: 'Edad',),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            DropdownButton(
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
            const SizedBox(height: 20,),
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
          setState(() {
            if(validarBoton(_textNombre.text, _textAp.text, _textAm.text, _textEdad.text, _textdir.text, _textTelefono.text, _textEsc.text)){
              db.crearProspecto(
                  Prospecto(
                      nombre: _textNombre.text,
                      primerApellido: _textAp.text,
                      segundoApellido: _textAm.text,
                      direccion: _textdir.text,
                      telefono: _textTelefono.text,
                      escolaridad: _textEsc.text,
                      edad: int.parse(_textEdad.text),
                      campana: dropdownvalueCamp)).whenComplete(() => Navigator.pop(context));
            }
          });
        }, child: const Text("Nuevo",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 25),))
      ],
    );

  }
}




