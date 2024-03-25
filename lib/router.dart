import 'package:awesome_project/pages/home/home_binding.dart';
import 'package:awesome_project/pages/home/home_view.dart';
import 'package:awesome_project/pages/next/next_binding.dart';
import 'package:awesome_project/pages/next/next_view.dart';
import 'package:get/get.dart';

class RouterGet {
  static final String home = "/";
  static final String next = "/next";

  static final List<GetPage> genRoutes = <GetPage>[
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: next, page: () => NextPage(), binding: NextBinding()),
  ];
}
