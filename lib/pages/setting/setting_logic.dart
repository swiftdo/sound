import 'package:get/get.dart';

import '../../constants.dart';
import '../../services/sp_service.dart';
import 'setting_state.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    final spService = Get.find<SpService>();
    state.launchPlay =
        spService.getBool(Constants.launchPlayKey, defValue: true) ?? true;
    state.playKeepWeak =
        spService.getBool(Constants.playKeepWeakKey, defValue: true) ?? true;
    update();
  }

  void changeLaunchPlay(bool launchPlay) {
    state.launchPlay = launchPlay;
    Get.find<SpService>().putBool(Constants.launchPlayKey, launchPlay);
    update();
  }

  void changePlayKeepWeak(bool playKeepWeak) {
    state.playKeepWeak = playKeepWeak;
    Get.find<SpService>().putBool(Constants.playKeepWeakKey, playKeepWeak);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
