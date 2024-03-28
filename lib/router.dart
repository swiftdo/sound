import 'package:awesome_project/pages/main/main_binding.dart';
import 'package:awesome_project/pages/main/main_view.dart';
import 'package:awesome_project/pages/musics/musics_binding.dart';
import 'package:awesome_project/pages/musics/musics_view.dart';
import 'package:awesome_project/pages/next/next_binding.dart';
import 'package:awesome_project/pages/next/next_view.dart';
import 'package:get/get.dart';

class RouterGet {
  static final String main = "/";
  static final String next = "/next";
  static final String musics = "/musics";

  static final List<GetPage> genRoutes = <GetPage>[
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: next, page: () => NextPage(), binding: NextBinding()),
    GetPage(name: musics, page: () => MusicsPage(), binding: MusicsBinding()),
  ];
}
