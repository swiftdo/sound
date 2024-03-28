import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'musics_logic.dart';

class MusicsPage extends StatelessWidget {
  MusicsPage({Key? key}) : super(key: key);

  final logic = Get.find<MusicsLogic>();
  final state = Get.find<MusicsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("声音"),
      ),
    );
  }
}
