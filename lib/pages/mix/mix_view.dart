import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mix_logic.dart';

// 声音混合
class MixPage extends StatelessWidget {
  MixPage({Key? key}) : super(key: key);

  final logic = Get.find<MixLogic>();
  final state = Get.find<MixLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
