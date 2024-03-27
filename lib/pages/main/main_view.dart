import 'package:awesome_project/pages/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../setting/setting_view.dart';
import 'main_logic.dart';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final logic = Get.find<MainLogic>();
  final state = Get.find<MainLogic>().state;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (MainLogic logic) {
      return Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            HomePage(),
            SettingPage(),
          ],
        ),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: state.selectedIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) {
            logic.updateSelectedIndex(index);
            _pageController.jumpToPage(index);
          },
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home),
              title: Text('首页'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.settings),
              title: Text('设置'),
            ),
          ],
        ),
      );
    });
  }
}
