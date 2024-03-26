import 'package:get/get.dart';

import '../../providers/gitlab_provider.dart';
import 'next_state.dart';

class NextLogic extends GetxController {
  final NextState state = NextState();
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
