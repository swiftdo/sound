import 'dart:convert';

import 'package:awesome_project/map_demo.dart';
import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

void main() {
  runMPApp(const MyApp());

  /**
   * 务必保留这段代码，否则第一次调用 wx 接口会提示异常。
   */
  if (kIsMPFlutter) {
    try {
      wx.$$context$$;
    } catch (e) {}
  }

  /**
   * 使用 AppDelegate 响应应用生命周期事件、分享事件。
   */
  // ignore: unused_local_variable
  final appDelegate = MyAppDelegate();
}

class MyAppDelegate {
  late MPFlutterWechatAppDelegate appDelegate;

  MyAppDelegate() {
    appDelegate = MPFlutterWechatAppDelegate(
      onShow: () {
        print("当应用从后台回到前台，被回调。");
      },
      onHide: () {
        print("当应用从前台切到后台，被回调。");
      },
      onShareAppMessage: (detail) {
        print("当用户点击分享给朋友时，回调，应组装对应的 Map 信息，用于展示和回跳。");
        return onShareAppMessage(detail);
      },
      onLaunch: (query, launchptions) async {
        print(launchptions['path']);
        print("应用冷启动时，会收到回调，应根据 query 决定是否要跳转页面。");
        await Future.delayed(Duration(seconds: 1)); // 加个延时，保障 navigator 已初始化。
        onLaunchOrEnter(query);
      },
      onEnter: (query, launchptions) {
        print("应用热启动（例如用户从分享卡片进入小程序）时，会收到回调，应根据 query 决定是否要跳转页面。");
        onLaunchOrEnter(query);
      },
    );
  }

  /**
   * 存在两种返回 Share Info 的方法
   * - MPFlutterWechatAppShareManager.onShareAppMessage 配合 MPFlutterWechatAppShareManager.setAppShareInfo 使用
   * - 直接返回符合微信小程序要求的 Map
   */
  Map onShareAppMessage(mpjs.JSObject detail) {
    return MPFlutterWechatAppShareManager.onShareAppMessage(detail);
    // final currentRoute = MPNavigatorObserver.currentRoute;
    // if (currentRoute != null) {
    //   final routeName = currentRoute.settings.name;
    //   return {
    //     "title": (() {
    //       if (routeName == "/map_demo") {
    //         return "Map Demo";
    //       } else {
    //         return "Awesome Project";
    //       }
    //     })(),
    //     "path":
    //         "pages/index/index?routeName=${routeName}", // 这个 query 会在 onLaunch 和 onEnter 中带回来。
    //   };
    // } else {
    //   return {};
    // }
  }

  void onLaunchOrEnter(Map query) {
    final navigator = MPNavigatorObserver.currentRoute?.navigator;
    if (navigator != null) {
      final routeName = query["routeName"];
      if (routeName == "/map_demo") {
        navigator.pushNamed("/map_demo");
      }
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 5.0,
          centerTitle: false,
        ),
        fontFamily: "MiniTex",
        fontFamilyFallback: ["MiniTex"],
        /**
         * 使用 iOS 风格页面转场
         */
        platform: TargetPlatform.iOS,
      ),
      routes: {
        '/map_demo': (context) => WXMapView(),
      },
      home: const MyHomePage(title: 'MPFlutter Awesome Page'),
      /**
       * 务必保留 MPNavigatorObserver，否则小程序的路由会出问题。
       */
      navigatorObservers: [MPNavigatorObserver()],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void wechatAPITest() {
    wx.getSystemInfoAsync(GetSystemInfoAsyncOption()
      ..success = (result) {
        final snackBar = SnackBar(
          content: Text('Device model = ${result.model}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
  }

  void toMapDemo() {
    Navigator.of(context).pushNamed('/map_demo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            MaterialButton(
              onPressed: () {
                wechatAPITest();
              },
              child: Text('Wechat API Test'),
            ),
            MaterialButton(
              onPressed: () {
                toMapDemo();
              },
              child: Text('Wechat Map Demo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
