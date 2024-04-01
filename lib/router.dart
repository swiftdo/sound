import 'package:awesome_project/pages/main/main_binding.dart';
import 'package:awesome_project/pages/main/main_view.dart'
    deferred as main_view;
import 'package:awesome_project/pages/mix/mix_binding.dart';
import 'package:awesome_project/pages/mix/mix_view.dart' deferred as mix_view;
import 'package:awesome_project/pages/musics/musics_binding.dart';
import 'package:awesome_project/pages/musics/musics_view.dart'
    deferred as musics_view;

import 'package:get/get.dart';

class RouterGet {
  static final String main = "/";
  static final String next = "/next";
  static final String musics = "/musics";
  static final String mix = "/mix";

  static Future<List<GetPage>> genRoutes() async {
    await main_view.loadLibrary();
    await musics_view.loadLibrary();
    await mix_view.loadLibrary();

    return [
      GetPage(
        name: main,
        page: () => main_view.MainPage(),
        binding: MainBinding(),
      ),
      GetPage(
        name: musics,
        page: () => musics_view.MusicsPage(),
        binding: MusicsBinding(),
      ),
      GetPage(
        name: mix,
        page: () => mix_view.MixPage(),
        binding: MixBinding(),
      ),
    ];
  }
}
