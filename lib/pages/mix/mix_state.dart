import '../../models/group_sound.dart';
import '../../providers/models/gt_main.dart';

enum MixPageState {
  sound,
  volume,
}

class MixState {
  GtMain? body;

  MixPageState mixPageState = MixPageState.sound;

  GroupSound activeSound = GroupSound(items: []);

  MixState() {
    ///Initialize variables
  }
}
