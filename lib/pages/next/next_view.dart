import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            return ListView.builder(
                padding: EdgeInsets.only(bottom: 50),
                itemBuilder: (context, index) {
                  return Column(
                    children: body.music[index].items.map((e) {
                      return Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset.zero)
                          ],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: AudioPlayerWidget(
                          audioUrl: body.musicBase + e.path,
                        ),
                      );
                    }).toList(),
                  );
                },
                itemCount: body.music.length);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  playAudio() {
    audioPlayer.play(UrlSource(widget.audioUrl));
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.audioUrl),
      trailing: IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: playAudio,
      ),
    );
  }
}
