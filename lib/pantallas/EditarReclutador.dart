import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:telsolreclutamiento/pantallas/ListaDereclutador.dart';
import 'package:flutter/services.dart';


class EditarReclutador extends StatefulWidget{
  @override
  State<EditarReclutador> createState() => _EditarReclutador();
}

class _EditarReclutador extends State<EditarReclutador>{
  final _textId = TextEditingController();
  final _textNombre = TextEditingController();
  final _textContra = TextEditingController();
  final Map <dynamic,dynamic> Reclutador = {
    'id':'101',
    'nombre': 'Yudith Garcia',
    'contra':'Telcel01',
    'habilitado': true
  };
  final Map <dynamic,dynamic> prueba = {};
  String nombre = '';
  String Contra = '';
  bool isChecked = false;
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
                      if(_textId != ''){
                        setState(() {
                          if(BuscarId('100').length != 0){
                            llenarCampos();
                          }else{
                            print('no se encontro');
                            //TODO logica si no encuentra el relcutador, como poner mensaje de error
                          }
                        });
                      }else{
                        print('llenar campo');//TODO agregarun texto que dice que falta llenar campo
                      }
                      }, child: Text('Buscar', style: TextStyle(color: Colors.white),))
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
                      Reclutador['habilitado'] = value!;
                      print(Reclutador.toString());
                    });
                  }),
                ],
              ),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListaDeReclutadores()));
              }, child: Text('Listo', style: TextStyle(color: Colors.white),))
            ],
          ),
        )
      ),
    );
  }
  Map <dynamic,dynamic> BuscarId(String id){
    return Reclutador;
  }

  void llenarCampos(){
    print(Reclutador['nombre']);
    _textNombre.text = Reclutador['nombre'];
    _textContra.text = Reclutador['contra'];
    isChecked = Reclutador['habilitado'];
  }

}