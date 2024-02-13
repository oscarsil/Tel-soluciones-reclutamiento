import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/database_helper.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';


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
      appBar: AppBar(
        title: Text(
          "Editar Reclutador",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Nombre Completo'),
              Container(
                width: 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child: TextFormField(
                  controller: _textNombre,
                ),
              ),
              const Text('Contraseña'),
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
                  const Text('Habilitado'),
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
                        widget.id).whenComplete((){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ListaDeReclutadores()));
                        });
                  }
                });
              }, child: const Text('Listo', style: TextStyle(color: Colors.white),)),
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