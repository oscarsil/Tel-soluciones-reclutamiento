import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/reproductor.dart';
import 'package:telsolreclutamiento/componentes/validarRespuestaExamenAuditorio.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:timer_count_down/timer_count_down.dart';

class examenAuditivo extends StatefulWidget {
  @override
  State<examenAuditivo> createState() => _examenAuditivo();
}

class _examenAuditivo extends State<examenAuditivo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: barraInformativa(titulo: 'Examen de Auditivo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Segundos Restantes'),
            Countdown(
                seconds: 120,
                build: (BuildContext context, double time) =>
                    Text(time.toString()),
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  setState(() {
                    examenterminado = true;
                    resultadofinal = vp.calcularcalificacion(vp.Calificacion(
                        NipSeleccionado,
                        FechaSeleccionada,
                        PromoSeleccionadda,
                        NacSeleccionada,
                        NombreSeleccionada,
                        Estadoseleccionado,
                        Cacseleccionado));
                  });
                }),
            reproductor(),
            QuestionOptions(),
            SizedBox(height: 30,),
            ButtonEnviarRespuestas(),
            SizedBox(
              height: 10,
            ),
            if (examenterminado) Text(resultadofinal.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}


class QuestionOptions extends StatefulWidget {
  @override
  State<QuestionOptions> createState() => _QuestionOption();
}

class _QuestionOption extends State<QuestionOptions> {
  String dropdownValue = 'respuesta';
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 500,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('Nip:'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  NipSeleccionado = value!;
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listNip.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('Fecha de Portabilidad:'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  FechaSeleccionada = value!;
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listFecha.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('Promocion:'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  PromoSeleccionadda = value!;
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listPromo.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('Fecha de Nacimiento:'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  NacSeleccionada = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listNac.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('Nombre'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  NombreSeleccionada = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listNombre.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('Estado:'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  Estadoseleccionado = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listEstados.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('CAC Cercano:'),
              Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  Cacseleccionado = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listCac.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          )
        ],
      ),
    ));
  }

  static List<String> listNip = <String>['5467', '4567', '6745', '4657'];
  static List<String> listFecha = <String>[
    '15/10/23',
    '25/09/23',
    '25/12/23',
    '15/09/23',
  ];
  static List<String> listPromo = <String>['50', '100', '150', '200'];
  static List<String> listNac = <String>[
    '24/06/64',
    '22/07/67',
    '23/05/67',
    '13/09/06'
  ];
  static List<String> listNombre = <String>[
    'jesus hernandez martinez',
    'jose moreno hernandez',
    'jose hernandez moreno',
    'joel moreno macinas'
  ];
  static List<String> listEstados = <String>[
    'chihuahua',
    'jalisco',
    'sinaloa',
    'sonora'
  ];
  static List<String> listCac = <String>[
    'Sun mall',
    'plaza sahuaro',
    'boulevard rodriguez',
    'plaza quiroga'
  ];
}

String NipSeleccionado = '';
String FechaSeleccionada = '';
String PromoSeleccionadda = '';
String NacSeleccionada = '';
String NombreSeleccionada = '';
String Estadoseleccionado = '';
String Cacseleccionado = '';

double resultadofinal = 0;
bool examenterminado = false;
bool faltarespuesta = false;

class ButtonEnviarRespuestas extends StatefulWidget {
  @override
  State<ButtonEnviarRespuestas> createState() => _ButtonEnviarRespuestas();
}

validarRespuestaExamenAuditorio vp = validarRespuestaExamenAuditorio();

class _ButtonEnviarRespuestas extends State<ButtonEnviarRespuestas> {
  double result = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              setState(() {
                if (vp.validarBoton(
                    NipSeleccionado,
                    FechaSeleccionada,
                    PromoSeleccionadda,
                    NacSeleccionada,
                    NombreSeleccionada,
                    Estadoseleccionado,
                    Cacseleccionado)) {
                  faltarespuesta = false;
                  examenterminado = true;
                  result = vp.calcularcalificacion(vp.Calificacion(
                      NipSeleccionado,
                      FechaSeleccionada,
                      PromoSeleccionadda,
                      NacSeleccionada,
                      NombreSeleccionada,
                      Estadoseleccionado,
                      Cacseleccionado));
                  resultadofinal = result;
                } else {
                  faltarespuesta = true;
                }
              });
            },
            child: Text(
              'Terminar',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        SizedBox(
          height: 10,
        ),
        if (faltarespuesta) Text('falta elejir'),

      ],
    );
  }
}
