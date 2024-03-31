import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/providers/models/gt_music.dart';
import 'package:get/get.dart';

import '../../providers/gitlab_provider.dart';
import 'mix_state.dart';

class MixLogic extends GetxController {
  final MixState state = MixState();
  final gitlabProvider = Get.find<GitlabProvider>();

  final Map<String, AudioPlayer> audioPlayerMap = {};

  @override
  void onReady() {
    super.onReady();
    getMainData();
  }

  @override
  void onClose() {
    audioPlayerMap.forEach((key, value) {
      value.stop();
      value.dispose();
    });

    audioPlayerMap.clear();

    super.onClose();
  }

  getMainData() async {
    final response = await gitlabProvider.getMainJson();
    state.body = response;
    update();
  }

  bool isPlaying(GtMusicItem item) {
    return state.activeSound.items.map((e) => e.path).contains(item.path);
  }

  selectSound(GtMusicItem item) {
    final audioPlayerKey = item.path;
    int index = state.activeSound.items
        .indexWhere((element) => element.path == audioPlayerKey);

    if (index >= 0) {
      state.activeSound.items.removeAt(index);
      audioPlayerMap[audioPlayerKey]?.pause();
      audioPlayerMap[audioPlayerKey]?.stop();
    } else {
      // 判断是否已满6个
      if (state.activeSound.items.length >= 6) {
        // 剔除第一个
        final first = state.activeSound.items.first;
        final firstPlayerKey = first.path;
        state.activeSound.items.removeAt(0);
        audioPlayerMap[firstPlayerKey]?.stop();
        audioPlayerMap[firstPlayerKey]?.dispose();
        audioPlayerMap.remove(firstPlayerKey);
      }
      state.activeSound.items.add(item);
      final audioPlayer = AudioPlayer();
      audioPlayer.setReleaseMode(ReleaseMode.loop);
      audioPlayer.play(UrlSource(item.path.url), volume: item.volume);
      audioPlayerMap[audioPlayerKey] = audioPlayer;
    }
    update();
  }

  tabOnTap(int index) {
    MixPageState pageState = MixPageState.values[index];
    if (pageState == state.mixPageState) {
      return;
    }
    togglePageState();
  }

  togglePageState() {
    if (state.mixPageState == MixPageState.sound) {
      state.mixPageState = MixPageState.volume;
    } else {
      state.mixPageState = MixPageState.sound;
    }
    update();
  }

  updateSoundVolume({
    required GtMusicItem soundItem,
    required double newVolume,
  }) {
    soundItem.volume = newVolume;
    final player = audioPlayerMap[soundItem.path];
    if (player != null) {
      player.setVolume(newVolume);
    }
  }
}
