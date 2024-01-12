import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/JefeReclutadorPrincipal.dart';

final _textNombreBuscar = TextEditingController();
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
  void diaspose(){
    _textNombreBuscar.dispose();
    _textNombre.dispose();
    _textAP.dispose();
    _textAM.dispose();
    _textEdad.dispose();
    _textSexo.dispose();
    _textTelefono.dispose();
    _textEscolaridad.dispose();
    _textestatus.dispose();
    _textMotivo.dispose();
    super.dispose;
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  PreferredSize(child: barraRegSal(titulo: 'Editar Prospecto',), preferredSize: Size.fromHeight(50)),
      body: Center(
        child: Form(
          key: formKey,
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
                              Text('Buscar por Nombre'),
                              SizedBox(width: 20,),
                              Container(
                                width: 200,
                                child: TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "nombreRequerido";
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ]"))
                                  ],
                                  controller: _textNombreBuscar,
                                ),
                              ),
                              SizedBox(width: 20,),
                              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: () => {
                              if(formKey.currentState!.validate()){

                              }
                              }, child: Text('Buscar por Nombre', style: TextStyle(color: Colors.white),))
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
      ),
    );
  }
}


class campos extends StatefulWidget {
  @override
  State<campos> createState() => _campos();
}

class _campos extends State<campos>{

  final formKey = GlobalKey<FormState>();
  String dropdownvalueCamp = 'Agente R02';

  var campanas = ['Agente R02','Agente R03','Renovaciones','Admin'];

  @override
  Widget build(BuildContext context){
    return Form(
      key: formKey,
      child: Column(
        children: [
          Wrap(
            children: [
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "nombre Requerido";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ]"))
                  ],
                  controller: _textNombre,
                  decoration: InputDecoration(
                    labelText: 'Nombre(s)',
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Apellido Requerido";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ]"))
                  ],
                  controller: _textAP,
                  decoration: InputDecoration(
                    labelText: 'Apellido Paterno'
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Apellido Requerido";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ]"))
                  ],
                  controller: _textAM,
                  decoration: InputDecoration(
                    labelText: 'Apellido Materno'
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 80,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "edad Requerido";
                    }
                    return null;
                  },
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ]"))
                  ],
                  controller: _textSexo,
                  decoration: InputDecoration(
                    labelText: 'Sexo'
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "telefono Requerido";
                    }
                    if(value.length == 10){
                      return null;
                    }else{
                      return "Telefono invalido";
                    }
                  },
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
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "escolaridad Requerido";
                    }
                    return null;
                  },
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
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "estatus Requerido";
                    }
                    return null;
                  },
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
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "motivo Requerido";
                    }
                    return null;
                  },
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
            if(formKey.currentState!.validate()){
              Navigator.push(context, MaterialPageRoute(builder: (context) => JefeReclutadorPrincipal()));
            }
          }, child: Text('Guardar', style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}