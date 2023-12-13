import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/JefeRecluPantallas/ListaDereclutador.dart';
import 'package:flutter/services.dart';


class EditarReclutador extends StatefulWidget{
  @override
  State<EditarReclutador> createState() => _EditarReclutador();
}

class _EditarReclutador extends State<EditarReclutador>{
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
    return  Scaffold(
      appBar: PreferredSize(child: barraRegSal(titulo: 'Editar Reclutador',), preferredSize: Size.fromHeight(50)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Buscar Reclutador por ID'),
                    SizedBox(width: 20,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      width: 200,
                      child: TextField(
                        controller: _textId,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: () {
                      setState(() {
                        if(_textId.text == ''){
                          buscarError = true;
                          buscarMensajeError = 'Falta llenar campo';
                        }else{
                        buscarError = false;
                        buscarMensajeError = '';
                        print("buscando");
                        }
                      });
                    }, child: Text('Buscar', style: TextStyle(color: Colors.white),)),
                    Container(
                      child: buscarError ? Text(buscarMensajeError) : null,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
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
                  Checkbox(value: isChecked, onChanged: (bool? value){
                    setState(() {
                      isChecked = value!;
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListaDeReclutadores()));
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