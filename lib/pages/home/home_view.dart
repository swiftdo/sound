import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/active_sound.dart';
import '../../services/sp_service.dart';
import '../../views/icon_button.dart';
import '../../views/player/needle_anim.dart';
import '../../views/player/record_anim.dart';
import 'home_logic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);

  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);

  late AnimationController controller_record;
  late Animation<double> animation_record;
  late Animation<double> animation_needle;
  late AnimationController controller_needle;

  final logic = Get.find<HomeLogic>();

  final state = Get.find<HomeLogic>().state;

  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });

    getCacheData();
  }

  getCacheData() async {
    debugPrint("🐶：：SpService HomeView use");
    final data = Get.find<SpService>().getObject(Constants.cacheActiveSound);
    debugPrint("🐶：：SpService HomeView use Success");
    if (data != null) {
      final sound = ActiveSound.fromJson(Map<String, dynamic>.from(data));
      Future.delayed(Duration(milliseconds: 500), () {
        logic.activeSound(sound);
        controller_record.forward();
        controller_needle.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("觅音"),
      ),
      body: GetBuilder(
        builder: (HomeLogic logic) {
          final activeSound = logic.state.activeSound;
          if (activeSound == null) {
            return Center(
              child: MaterialButton(
                onPressed: () async {
                  selectMusic();
                },
                child: Text('选择声音'),
              ),
            );
          }
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: const FractionalOffset(0.7, 0.1),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (state.isPlaying) {
                          stopPlay();
                        } else {
                          restartPlay();
                        }
                      },
                      child: Container(
                        child: RotateRecord(
                          animation: _commonTween.animate(controller_record),
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(125),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset.zero,
                                      blurRadius: 10),
                                ]),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.network(
                                  activeSound.icon.url,
                                  width: 120,
                                  height: 120,
                                ),
                              ],
                            ),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 100.0),
                      ),
                    ),
                    Container(
                      child: new PivotTransition(
                        turns: _rotateTween.animate(controller_needle),
                        alignment: FractionalOffset.topLeft,
                        child: new Container(
                          width: 100.0,
                          child: Image.network("play_needle".png),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFAFAFA),
                    ),
                    child: Wrap(
                      spacing: 24,
                      children: [
                        VIconButton(
                          title: '定时',
                          onTap: () {},
                          icon: Icons.timer,
                        ),
                        GestureDetector(
                          onTap: () async {
                            stopPlay();
                            final res = await Get.toNamed(RouterGet.mix);
                            if (res != null) {
                              logic.activeSound(res);
                            }
                          },
                          child: Container(
                            width: 80,
                            height: 44,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(22)),
                            child: Icon(
                              Icons.add,
                              size: 22,
                            ),
                          ),
                        ),
                        VIconButton(
                          title: "列表",
                          onTap: () {
                            selectMusic();
                          },
                          icon: Icons.queue_music,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller_record.dispose();
    controller_needle.dispose();
    super.dispose();
  }

  selectMusic() async {
    final activeSound = await Get.toNamed(RouterGet.musics);
    if (activeSound is ActiveSound) {
      logic.activeSound(activeSound);
      controller_record.forward();
      controller_needle.forward();
    }
  }

  void stopPlay() {
    logic.pause();
    controller_record.stop(canceled: false);
    controller_needle.reverse();
  }

  void restartPlay() {
    logic.play();
    controller_record.forward();
    controller_needle.forward();
  }
}
