import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/database_helper.dart';


class EditarReclutador extends StatefulWidget{
  final int? id;
  final String username, password;
  bool habilitado;
  EditarReclutador({
    required this.id,
    required this.username,
    required this.password,
    required this.habilitado
});
  @override
  State<EditarReclutador> createState() => _EditarReclutador();
}

class _EditarReclutador extends State<EditarReclutador>{
  @override
  void dispose(){
    _textId.dispose();
    _textNombre.dispose();
    _textContra.dispose();
    super.dispose();
  }

  int editarHabilitado(bool habilitado){
    if(habilitado){return 1;}else{return 0;}
  }

  final db = database_helper();

  final _textId = TextEditingController();
  final _textNombre = TextEditingController();
  final _textContra = TextEditingController();


  bool isChecked = false;
  bool buscarError = false;
  String buscarMensajeError = '';

  bool editarError = false;
  String editarErrorMensaje = '';

  @override
  Widget build(BuildContext context){
    _textNombre.text = widget.username;
    _textContra.text = widget.password;
    return  Scaffold(
      appBar: PreferredSize(child: barraRegSal(titulo: 'Editar Reclutador',), preferredSize: Size.fromHeight(50)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Nombre Completo'),
              Container(
                width: 200,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child: TextFormField(
                  controller: _textNombre,
                ),
              ),
              Text('Contraseña'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                width: 200,
                child: TextFormField(
                  controller: _textContra,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Habilitado'),
                  Checkbox(
                      value: widget.habilitado,
                      onChanged: (newvalue){
                    setState(() {
                      widget.habilitado = newvalue!;
                    });
                  }),
                ],
              ),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: ()  {
                setState(() {
                  if(_textNombre.text =='' || _textContra.text == ''){
                    editarError = true;
                    editarErrorMensaje = 'Falta llenar campo';
                  }else{
                    editarError = false;
                    editarErrorMensaje = '';
                    db.editarReclutador(
                        _textNombre.text,
                        _textContra.text,
                        editarHabilitado(widget.habilitado),
                        widget.id).whenComplete((){Navigator.pop(context);});
                  }
                });
              }, child: Text('Listo', style: TextStyle(color: Colors.white),)),
              Container(
                child: editarError ? Text(editarErrorMensaje) : null,
              )
            ],
          ),
        )
      ),
    );
  }
}