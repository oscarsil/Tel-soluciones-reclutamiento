import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/JefeRecluElegirProsEditar.dart';
import 'package:telsolreclutamiento/pantallas/ReclutadorPantallas/RecluElegirProsEditar.dart';

final _textNombre = TextEditingController();
final _textAP = TextEditingController();
final _textAM = TextEditingController();
final _textEdad = TextEditingController();
final _textDireccion = TextEditingController();
final _textTelefono = TextEditingController();
final _textEscolaridad = TextEditingController();
final _textestatus = TextEditingController();
final _textMotivo = TextEditingController();


class EditarProspecto extends StatefulWidget{
  final String user;
  final Prospecto pros;
  const EditarProspecto({
    required this.pros,
    required this.user
  });
  @override
  State<EditarProspecto> createState() => _EditarProspecto();
}

class _EditarProspecto extends State<EditarProspecto>{

  final db = database_helper();

  void cleartext(){
    _textNombre.clear();
    _textAP.clear();
    _textAM.clear();
    _textEdad.clear();
    _textTelefono.clear();
    _textEscolaridad.clear();
    _textDireccion.clear();
    _textestatus.clear();
    _textMotivo.clear();
  }

  var campanas = ['Agente R02','Agente R03','Renovaciones','Admin'];


  @override
  Widget build(BuildContext context){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _textNombre.text = widget.pros.nombre;
      _textAP.text = widget.pros.primerApellido;
      _textAM.text = widget.pros.segundoApellido;
      _textEdad.text = widget.pros.edad.toString();
      _textTelefono.text = widget.pros.telefono;
      _textEscolaridad.text = widget.pros.escolaridad;
      _textDireccion.text = widget.pros.direccion;
      widget.pros.estatus == null ? _textestatus.text = "Sin estatus" : _textestatus.text = widget.pros.estatus.toString();
      widget.pros.motivo == null ? _textMotivo.text = "N/A" : _textMotivo.text = widget.pros.motivo.toString();
    });


    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar:  AppBar(
        title: Text(
          "Editar Prospecto",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
          child: Form(
             key: formKey,
             child: SingleChildScrollView(
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
                             FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ ]"))
                           ],
                           controller: _textNombre,
                           decoration: const InputDecoration(
                             labelText: 'Nombre(s)',
                           ),
                         ),
                       ),
                       const SizedBox(width: 10,),
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
                             FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ ]"))
                           ],
                           controller: _textAP,
                           decoration: const InputDecoration(
                               labelText: 'Apellido Paterno'
                           ),
                         ),
                       ),
                       const SizedBox(width: 10,),
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
                             FilteringTextInputFormatter.allow(RegExp("[a-zA-Zñ˜Ñ ]"))
                           ],
                           controller: _textAM,
                           decoration: const InputDecoration(
                               labelText: 'Apellido Materno'
                           ),
                         ),
                       ),
                       const SizedBox(width: 10,),
                       SizedBox(
                         width: 300,
                         child: TextFormField(
                           validator: (value){
                             if(value!.isEmpty){
                               return "direccion Requerido";
                             }
                             return null;
                           },
                           controller: _textDireccion,
                           decoration: const InputDecoration(
                             labelText: 'Direccion',),
                         ),
                       ),
                       const SizedBox(width: 10,),
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
                           decoration: const InputDecoration(
                             labelText: 'Edad',),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[
                             FilteringTextInputFormatter.digitsOnly
                           ],
                         ),
                       ),
                       const SizedBox(width: 10,),
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
                           decoration: const InputDecoration(
                               labelText: 'Telefono'
                           ),
                           inputFormatters: <TextInputFormatter>[
                             FilteringTextInputFormatter.digitsOnly
                           ],
                         ),
                       ),
                       const SizedBox(width: 10,),
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
                           decoration: const InputDecoration(
                               labelText: 'Escolaridad'
                           ),
                         ),
                       ),
                       const SizedBox(width: 10,),
                       DropdownButton(
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
                       const SizedBox(width: 10,),
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
                           decoration: const InputDecoration(
                               labelText: 'Estatus'
                           ),
                         ),
                       ),
                       const SizedBox(width: 10,),
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
                           decoration: const InputDecoration(
                               labelText: 'Motivo'
                           ),
                         ),
                       )
                     ],
                   ),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       ElevatedButton(
                           style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                           onPressed: () {
                         if(widget.user=="Jefe"){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => JefeRecluElegirProsEditar()));
                         } else if(widget.user=="Reclutador"){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => RecluElegirProsEditar()));
                         }
                       }, child: const Text('Cancelar', style: TextStyle(color: Colors.white),)),
                       SizedBox(width: 50,),
                       ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: ()  {
                         if(formKey.currentState!.validate()){
                           db.editarProspecto(
                             _textNombre.text,
                             _textAP.text,
                             _textAM.text,
                             _textDireccion.text,
                             _textTelefono.text,
                             _textEscolaridad.text,
                             int.parse(_textEdad.text),
                             dropdownvalueCamp,
                             _textestatus.text,
                             _textMotivo.text,
                             widget.pros.id
                           ).whenComplete(() {
                             if(widget.user=="Jefe"){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => JefeRecluElegirProsEditar()));
                             } else if(widget.user=="Reclutador"){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => RecluElegirProsEditar()));
                             }
                           });
                         }
                       }, child: const Text('Guardar', style: TextStyle(color: Colors.white),)),
                     ],
                   )
                 ],
               ),
             ),
           ),
      ),
    );
  }
}

String dropdownvalueCamp = 'Agente R02';



//JefeReclutadorPrincipal()