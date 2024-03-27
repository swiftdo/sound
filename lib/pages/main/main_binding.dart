import 'package:awesome_project/pages/home/home_logic.dart';
import 'package:awesome_project/pages/setting/setting_logic.dart';
import 'package:get/get.dart';

import 'main_logic.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainLogic());
    Get.lazyPut(() => SettingLogic());
    Get.lazyPut(() => HomeLogic());
  }
}
