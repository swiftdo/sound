import 'package:get/get.dart';

import '../../providers/gitlab_provider.dart';
import 'musics_logic.dart';

class MusicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GitlabProvider());
    Get.lazyPut(() => MusicsLogic());
  }
}
