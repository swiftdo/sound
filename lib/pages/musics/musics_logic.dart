import 'package:get/get.dart';

import '../../providers/gitlab_provider.dart';
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
    update();
  }
}
