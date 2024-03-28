import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/models/active_sound.dart';
import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  final List<AudioPlayer> audioPlayers = [];

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.stop();
      audioPlayer.dispose();
    }
    audioPlayers.clear();
    super.onClose();
  }

  activeSound(ActiveSound sound) {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.stop();
      audioPlayer.dispose();
    }
    audioPlayers.clear();
    state.activeSound = sound;

    for (final item in sound.items) {
      final audioPlayer = AudioPlayer();
      audioPlayer.play(UrlSource(item.path.url), volume: item.volume);
      audioPlayers.add(audioPlayer);
    }
    update();
  }

  // 暂停
  pause() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.pause();
    }
  }

  // 播放
  play() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.resume();
    }
  }
}
