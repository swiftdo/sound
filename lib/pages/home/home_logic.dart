import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/models/active_sound.dart';
import 'package:awesome_project/services/sp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
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
    debugPrint("🐶：：SpService activeSound use");
    Get.find<SpService>().putObject(Constants.cacheActiveSound, sound.toJson());
    debugPrint("🐶：：SpService activeSound use success");

    for (final item in sound.items) {
      final audioPlayer = AudioPlayer();
      audioPlayer.setAudioContext(
        AudioContext(
          android: AudioContextAndroid(stayAwake: true),
          iOS: AudioContextIOS(category: AVAudioSessionCategory.playback),
        ),
      );
      audioPlayer.play(UrlSource(item.path.url), volume: item.volume);
      audioPlayers.add(audioPlayer);
    }
    state.isPlaying = true;
    update();
  }

  // 暂停
  pause() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.pause();
    }
    state.isPlaying = false;
    refresh();
  }

  // 播放
  play() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.resume();
    }
    state.isPlaying = true;
    refresh();
  }
}
