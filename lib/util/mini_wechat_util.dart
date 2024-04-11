import 'package:flutter/material.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../services/sp_service.dart';

class MiniWechatUtil {
  // 保持不息屏
  static keepWeak() {
    final keepWeak = Get.find<SpService>()
            .getBool(Constants.playKeepWeakKey, defValue: true) ??
        true;
    SetKeepScreenOnOption option = SetKeepScreenOnOption();
    option..keepScreenOn = keepWeak;
    wx.setKeepScreenOn(option);
  }

  // 允许息屏
  static allowSleep() {
    SetKeepScreenOnOption option = SetKeepScreenOnOption();
    option..keepScreenOn = false;
    wx.setKeepScreenOn(option);
  }

  static copyText(String text) {
    final opt = SetClipboardDataOption()
      ..data = text
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
}
