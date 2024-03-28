import 'package:get/get.dart';

import 'musics_logic.dart';

class MusicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MusicsLogic());
  }
}
