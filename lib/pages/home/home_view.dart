import 'package:awesome_project/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        title: Text("HOME"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.network(
              "https://jihulab.com/OHeroJ/sound/-/raw/main/music/nature/1-forest1.svg",
              width: 40,
              height: 40,
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
