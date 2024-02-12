import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telsolreclutamiento/pantallas/inicioPantallas/NombreProspecto.dart';


class introducirIdProspecto extends StatefulWidget{
  final int? idReclu;
  final String UsernameReclu;
  const introducirIdProspecto({
    required this.idReclu,
    required this.UsernameReclu
});
  @override
  State<introducirIdProspecto> createState() => _introducirIdProspectoState();
}

class _introducirIdProspectoState extends State<introducirIdProspecto> {
  final _idController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Introducir ID Prospecto"),),
      body:  Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              Text("Por favor de poner id de prospecto que va realizar examenes"),
              SizedBox(height: 10,),
              SizedBox(
                width: 140,
                child:  TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: (value){
                    if(value!.isEmpty){
                      return "ID Requerido";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _idController,
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                if(formKey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => nombreProspecto(id: int.parse(_idController.text), idReclu: widget.idReclu, UsernameReclu: widget.UsernameReclu,)));
                }
              }, child: Text("Seguir"))
            ],
          ),
        ),
      ),
    );
  }
}