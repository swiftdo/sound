import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/filling_slider.dart';
import 'next_logic.dart';

class NextPage extends StatelessWidget {
  NextPage({Key? key}) : super(key: key);

  final logic = Get.find<NextLogic>();
  final state = Get.find<NextLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['name']),
      ),
      body: GetBuilder(
        builder: (NextLogic logic) {
          final body = logic.state.body;
          if (body == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 50),
              child: Column(
                children: body.music.map((item) {
                  return Column(
                    children: item.items.map((e) {
                      return AudioPlayerWidget(
                          audioUrl: body.musicBase + e.path);
                    }).toList(),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer audioPlayer;
  double volume = 1.0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  playAudio() {
    audioPlayer.play(UrlSource(widget.audioUrl), volume: volume);
    setState(() {
      isPlaying = true;
    });
  }

  pauseAudio() {
    audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  setVolume(double newVolume) {
    volume = newVolume;
    audioPlayer.setVolume(volume);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset.zero)
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.audioUrl)),
              isPlaying
                  ? IconButton(
                      onPressed: pauseAudio,
                      icon: Icon(Icons.pause),
                    )
                  : IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: playAudio,
                    )
            ],
          ),
          if (isPlaying)
            FillingSlider(
              direction: FillingSliderDirection.vertical,
              initialValue: volume,
              onFinish: setVolume,
              onChange: (newVolume, oldVolume) {
                setVolume(newVolume);
                print("$newVolume $oldVolume");
              },
            ),
        ],
      ),
    );
  }
}
