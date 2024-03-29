import 'package:get/get.dart';

import 'mix_logic.dart';

class MixBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MixLogic());
  }
}
