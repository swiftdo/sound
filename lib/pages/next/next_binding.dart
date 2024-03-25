import 'package:get/get.dart';

import 'next_logic.dart';

class NextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NextLogic());
  }
}
