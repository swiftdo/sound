import 'package:awesome_project/pages/main/main_binding.dart';
import 'package:awesome_project/pages/main/main_view.dart'
    deferred as main_view;
import 'package:awesome_project/pages/musics/musics_binding.dart';
import 'package:awesome_project/pages/musics/musics_view.dart'
    deferred as musics_view;
import 'package:awesome_project/pages/next/next_binding.dart';
import 'package:awesome_project/pages/next/next_view.dart'
    deferred as next_view;
import 'package:get/get.dart';

class RouterGet {
  static final String main = "/";
  static final String next = "/next";
  static final String musics = "/musics";

  static Future<List<GetPage>> genRoutes() async {
    await main_view.loadLibrary();
    await musics_view.loadLibrary();
    await next_view.loadLibrary();

    return [
      GetPage(
        name: main,
        page: () => main_view.MainPage(),
        binding: MainBinding(),
      ),
      GetPage(
        name: next,
        page: () => next_view.NextPage(),
        binding: NextBinding(),
      ),
      GetPage(
        name: musics,
        page: () => musics_view.MusicsPage(),
        binding: MusicsBinding(),
      ),
    ];
  }
}
