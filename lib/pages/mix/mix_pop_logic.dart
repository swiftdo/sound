import 'package:get/get.dart';

import 'mix_pop_state.dart';

class MixPopLogic extends GetxController {
  final MixPopState state = MixPopState();

  updateTitle(String title) {
    state.title = title;
    update();
  }

  updatePath(String path) {
    state.path = path;
    update();
  }
}
