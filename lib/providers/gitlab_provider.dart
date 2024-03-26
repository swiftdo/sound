import 'dart:convert';

import 'package:get/get.dart';

import 'models/gt_main.dart';

class GitlabProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://jihulab.com/OHeroJ/sound/-/raw/main/';
  }

  Future<GtMain> getMainJson() async {
    final response = await get('music.json');
    final body = jsonDecode(response.body);
    return GtMain.fromJson(body);
  }
}
