import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/models/active_sound.dart';
import 'package:awesome_project/services/sp_service.dart';
import 'package:awesome_project/util/mini_wechat_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';

import '../../constants.dart';
import '../../providers/models/gt_music.dart';
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

  // 重新设置播放源
  activeSound(ActiveSound sound, {bool autoPlay = true}) {
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
      audioPlayer.setReleaseMode(ReleaseMode.loop);

      _audioPlayer(audioPlayer, item: item, autoPlay: autoPlay);

      audioPlayers.add(audioPlayer);
    }
    state.isPlaying = autoPlay;
    update();
  }

  _audioPlayer(
    AudioPlayer audioPlayer, {
    required GtMusicItem item,
    bool autoPlay = true,
  }) async {
    try {
      await audioPlayer.play(UrlSource(item.path.url), volume: item.volume);
      if (!autoPlay) {
        audioPlayer.pause();
        MiniWechatUtil.allowSleep();
      } else {
        MiniWechatUtil.keepWeak();
      }
    } catch (e) {
      debugPrint("🐶：：$e");
    }
  }

  // 暂停
  pause() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.pause();
    }
    state.isPlaying = false;
    update();
    MiniWechatUtil.allowSleep();
  }

  // 播放
  play() {
    for (final audioPlayer in audioPlayers) {
      audioPlayer.resume();
    }
    state.isPlaying = true;
    update();
    MiniWechatUtil.keepWeak();
  }
}
