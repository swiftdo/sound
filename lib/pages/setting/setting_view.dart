import 'package:awesome_project/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'setting_logic.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:mpflutter_wechat_button/mpflutter_wechat_button.dart';

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
      body: GetBuilder(
        builder: (SettingLogic logic) {
          return ListView(
            padding: EdgeInsets.all(10).copyWith(bottom: 300),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset.zero,
                        blurRadius: 5,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('启动后自动播放'),
                          Checkbox(
                            value: state.launchPlay,
                            onChanged: (val) {
                              logic.changeLaunchPlay(val ?? false);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: MPFlutter_Wechat_Button(
                        openType: "contact",
                        onContact: (detail) {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('问题反馈'),
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouterGet.aboutus);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('关于我们'),
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '觅音由 ',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (kIsMPFlutter) {
                                final opt = SetClipboardDataOption()
                                  ..data =
                                      'https://github.com/mpflutter/mpflutter'
                                  ..success = (res) {
                                    Get.snackbar(
                                      "复制成功",
                                      "已将链接拷贝到粘贴板中",
                                      margin: EdgeInsets.all(20),
                                    );
                                  }
                                  ..fail = (err) {
                                    Get.snackbar(
                                      "复制失败",
                                      "请重试::${err.errMsg}",
                                      margin: EdgeInsets.all(20),
                                    );
                                  }
                                  ..complete = (res) {
                                    debugPrint("复制完成:: ${res.errMsg}");
                                  };
                                wx.setClipboardData(opt);
                              }
                            },
                            child: Text(
                              'mpflutter2.0',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ' 构建',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
