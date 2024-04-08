import 'package:get/get.dart';

import 'aboutus_logic.dart';

class AboutusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutusLogic());
  }
}
