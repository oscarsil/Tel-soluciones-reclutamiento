import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/validarRespuestaExamenAuditorio.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:telsolreclutamiento/pantallas/ExamenesPantallas/Apto.dart';
import 'package:telsolreclutamiento/database_helper.dart';

class examenAuditivo extends StatefulWidget {
  final int prospecto_id;
  final int quizzscore;
  final double tecladoscore;

  const examenAuditivo(
      {required this.prospecto_id,
      required this.quizzscore,
      required this.tecladoscore});

  @override
  State<examenAuditivo> createState() => _examenAuditivo();
}

class _examenAuditivo extends State<examenAuditivo> {
  double resultadofinal = 0;

  int wpmtograde(double wpm) {
    if (wpm >= 45) {
      return 100;
    } else {
      return ((wpm * 100) / 45).toInt();
    }
  }

  final db = database_helper();

  final CountdownController _controller =
      new CountdownController(autoStart: true);

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  Future stopAudio() async {
    await audioPlayer.stop();
  }

  Future setAudio() async {
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load('Pregunta_Audio.mp3');
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [minutes, seconds].join(':');
  }

  @override
  void initState() {
    _controller.restart();
    clearSeleccionado();
    super.initState();
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: barraInformativa(titulo: 'Examen de Auditivo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Segundos Restantes'),
            Countdown(
                controller: _controller,
                seconds: 120,
                build: (BuildContext context, double time) =>
                    Text(time.toString()),
                interval: const Duration(milliseconds: 100),
                onFinished: () {
                  print("finished");
                  audioPlayer.stop();
                  db
                      .editarCalificacionProspecto(
                          this.widget.quizzscore,
                          wpmtograde(this.widget.tecladoscore),
                          double.parse(vp
                                  .calcularcalificacion(vp.Calificacion(
                                      NipSeleccionado,
                                      FechaSeleccionada,
                                      PromoSeleccionadda,
                                      NacSeleccionada,
                                      NombreSeleccionada,
                                      Estadoseleccionado,
                                      Cacseleccionado))
                                  .toStringAsFixed(2))
                              .toInt(),
                          this.widget.prospecto_id)
                      .whenComplete(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => apto(
                                    prospecto_id: this.widget.prospecto_id,
                                    quizzscore: this.widget.quizzscore,
                                    tecladoscore: this.widget.tecladoscore,
                                    auditivoscore: vp
                                        .calcularcalificacion(vp.Calificacion(
                                        NipSeleccionado,
                                        FechaSeleccionada,
                                        PromoSeleccionadda,
                                        NacSeleccionada,
                                        NombreSeleccionada,
                                        Estadoseleccionado,
                                        Cacseleccionado)),
                                  ))));
                }),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                await audioPlayer.resume();
              },
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration)),
                  ],
                )),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
              ),
            ),
            QuestionOptions(),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  _controller.pause();
                  audioPlayer.stop();
                  print(wpmtograde(this.widget.tecladoscore));
                  db.editarCalificacionProspecto(
                          this.widget.quizzscore,
                          wpmtograde(this.widget.tecladoscore),
                          double.parse(vp
                                  .calcularcalificacion(vp.Calificacion(
                                      NipSeleccionado,
                                      FechaSeleccionada,
                                      PromoSeleccionadda,
                                      NacSeleccionada,
                                      NombreSeleccionada,
                                      Estadoseleccionado,
                                      Cacseleccionado))
                                  .toStringAsFixed(2))
                              .toInt(),
                          this.widget.prospecto_id)
                      .whenComplete(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => apto(
                                    prospecto_id: this.widget.prospecto_id,
                                    quizzscore: this.widget.quizzscore,
                                    tecladoscore: this.widget.tecladoscore,
                                    auditivoscore: vp
                                        .calcularcalificacion(vp.Calificacion(
                                        NipSeleccionado,
                                        FechaSeleccionada,
                                        PromoSeleccionadda,
                                        NacSeleccionada,
                                        NombreSeleccionada,
                                        Estadoseleccionado,
                                        Cacseleccionado))
                                  ))));
                },
                child: const Text(
                  'Terminar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
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
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('Cual es el Nip?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  NipSeleccionado = value!;
                  setState(() {
                    dropdownValue = value;
                  });
                },
                dropdownMenuEntries:
                    listNip.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('Que fecha es el Fecha de Portabilidad?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  FechaSeleccionada = value!;
                  setState(() {
                    dropdownValue = value;
                  });
                },
                dropdownMenuEntries:
                    listFecha.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('que Promocion escojio el cliente?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  PromoSeleccionadda = value!;
                  setState(() {
                    dropdownValue = value;
                  });
                },
                dropdownMenuEntries:
                    listPromo.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('cual es el Fecha de Nacimiento de cliente?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  NacSeleccionada = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value;
                  });
                },
                dropdownMenuEntries:
                    listNac.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('cual es el Nombre del ciente?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  NombreSeleccionada = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value;
                  });
                },
                dropdownMenuEntries:
                    listNombre.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('en que Estado fue registrado?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  Estadoseleccionado = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value;
                  });
                },
                dropdownMenuEntries:
                    listEstados.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text('cual es su CAC mas Cercano?'),
              const Spacer(),
              DropdownMenu<String>(
                onSelected: (String? value) {
                  Cacseleccionado = value!;
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value;
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

void clearSeleccionado () {
   NipSeleccionado = '';
   FechaSeleccionada = '';
   PromoSeleccionadda = '';
   NacSeleccionada = '';
   NombreSeleccionada = '';
   Estadoseleccionado = '';
   Cacseleccionado = '';
}

validarRespuestaExamenAuditorio vp = validarRespuestaExamenAuditorio();
