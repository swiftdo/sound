import 'package:get/get.dart';

import '../../providers/gitlab_provider.dart';
import 'mix_state.dart';

class MixLogic extends GetxController {
  final MixState state = MixState();
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

  getMainData() async {
    final response = await gitlabProvider.getMainJson();
    state.body = response;
    update();
  }
}
