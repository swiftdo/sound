import 'dart:convert';

import 'package:get/get.dart';

import 'models/gt_main.dart';
import 'package:awesome_project/constants.dart';

class GitlabProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.gitlabBaseUrl;
  }

  Future<GtMain> getMainJson() async {
    final response = await get('music.json');
    final body = jsonDecode(response.bodyString!);
    return GtMain.fromJson(body);
  }
}
