import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class reproductor extends StatefulWidget{
  @override
  State<reproductor> createState() => _reproductorState();
}

class _reproductorState extends State<reproductor>{
  Future setAudio() async {
    final player = AudioCache(prefix:  'assets/');
    final url = await player.load('Pregunta_Audio.mp3');
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      minutes,
      seconds
    ].join(':');
  }


  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
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


  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        children: [
          Slider(
            min:0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);

              await audioPlayer.resume();
            },
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              )
          ),
          CircleAvatar(
            radius: 35,
            child: IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 50,
              onPressed: () async {
                if(isPlaying){
                  await audioPlayer.pause();
                }else{
                  await audioPlayer.resume();
                }
              },
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}