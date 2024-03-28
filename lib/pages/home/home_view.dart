import 'package:awesome_project/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/icon_button.dart';
import 'home_logic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("觅音"),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.network(
                  "https://jihulab.com/OHeroJ/sound/-/raw/main/music/nature/1-forest1.svg",
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VIconButton(
                    title: '定时',
                    onTap: () {},
                    icon: Icons.timer,
                  ),
                  VIconButton(
                    title: "列表",
                    onTap: () {
                      Get.toNamed(RouterGet.musics);
                    },
                    icon: Icons.queue_music,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
