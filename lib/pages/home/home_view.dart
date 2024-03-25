import 'dart:math';

import 'package:awesome_project/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  void _incrementCounter() {
    logic.updateCount();
  }

  void wechatAPITest() {
    // wx.getSystemInfoAsync(GetSystemInfoAsyncOption()
    //   ..success = (result) {
    //     final snackBar = SnackBar(
    //       content: Text('Device model = ${result.model}'),
    //     );
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   });
  }

  void toMapDemo() {
    // Navigator.of(context).pushNamed('/map_demo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("HOME"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many test5 times :',
            ),
            GetBuilder(builder: (HomeLogic logic) {
              return Text(
                '${logic.state.counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            MaterialButton(
              onPressed: () {
                wechatAPITest();
              },
              child: Text('Wechat API Test'),
            ),
            MaterialButton(
              onPressed: () {
                toMapDemo();
              },
              child: Text('Wechat Map Demo'),
            ),
            MaterialButton(
              onPressed: () {
                Get.toNamed(RouterGet.next, arguments: {"name": "Next TEST"});
              },
              child: Text('Next Demo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
