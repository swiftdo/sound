import 'package:awesome_project/constants.dart';
import 'package:awesome_project/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';

import 'aboutus_logic.dart';

class AboutusPage extends StatelessWidget {
  AboutusPage({Key? key}) : super(key: key);

  final logic = Get.find<AboutusLogic>();
  final state = Get.find<AboutusLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('觅音之旅'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                '觅音之旅',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '觅音 – 以大自然的声音为灵感，轻松创建专注或放松的音乐氛围。无论是在繁忙的办公室，还是在家中的安静角落，觅音将简约与宁静相结合，帮助您从快节奏中脱离，为您提供一个没有干扰的平静时空，保持专注、冥想片刻、放松思绪。',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () {
                    final opt = SetClipboardDataOption()
                      ..data = Constants.soundUrl
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
                  },
                  child: Row(
                    children: [
                      Text(
                        '开源地址:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        Constants.soundUrl,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            child: SvgPicture.network(
              "sound_log".svg,
              width: 200,
              height: 200,
            ),
            bottom: 80,
            right: 30,
          )
        ],
      ),
    );
  }
}
