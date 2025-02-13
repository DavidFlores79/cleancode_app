import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String audioUrl;
  const CustomAudioPlayer({super.key, required this.audioUrl});

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    _audioPlayer = AudioPlayer();

    // Escucha el estado de reproducción (playing)
    _audioPlayer.playingStream.listen((isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    });

    // Escucha el estado de procesamiento (opcional)
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  Future<void> _playAudio() async {
    debugPrint("_playAudio");
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.setUrl(widget.audioUrl);
        await _audioPlayer.play();
      }
    } catch (e) {
      print("Error al reproducir el audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _isPlaying ? 'Reproduciendo...':'Reproducir audio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _playAudio,
              iconSize: 35,
            ),
          ],
        ),
      ],
    );
  }
}