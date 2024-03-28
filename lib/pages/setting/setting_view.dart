import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingLogic>();
  final state = Get.find<SettingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Container(
        child: Text('版本号: v1.0.0'),
      ),
    );
  }
}
