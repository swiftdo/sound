import 'package:awesome_project/providers/gitlab_provider.dart';
import 'package:get/get.dart';

import 'mix_logic.dart';

class MixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MixLogic());
    Get.lazyPut(() => GitlabProvider());
  }
}
