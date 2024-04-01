import 'package:awesome_project/constants.dart';
import 'package:awesome_project/models/group_sound.dart';
import 'package:get/get.dart';

import '../../providers/gitlab_provider.dart';
import '../../services/sp_service.dart';
import 'musics_state.dart';

class MusicsLogic extends GetxController {
  final MusicsState state = MusicsState();
  final gitlabProvider = Get.find<GitlabProvider>();

  @override
  void onReady() {
    super.onReady();
    getMainData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getMainData() async {
    final response = await gitlabProvider.getMainJson();
    state.body = response;
    getMixList();
    // 获取到混合列表
    update();
  }

  getMixList() async {
    final spService = Get.find<SpService>();
    final res = spService.getObject(Constants.cacheMixMapKey);
    if (res != null) {
      state.mixList =
          List.from(res.values).map((e) => GroupSound.fromJson(e)).toList();
    }
  }
}
