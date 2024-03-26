import 'package:awesome_project/providers/gitlab_provider.dart';
import 'package:get/get.dart';

import 'next_logic.dart';

class NextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NextLogic());
    Get.lazyPut(() => GitlabProvider());
  }
}
