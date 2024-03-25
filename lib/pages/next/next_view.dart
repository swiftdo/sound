import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'next_logic.dart';

class NextPage extends StatelessWidget {
  NextPage({Key? key}) : super(key: key);

  final logic = Get.find<NextLogic>();
  final state = Get.find<NextLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['name']),
      ),
    );
  }
}
