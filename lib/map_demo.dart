import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_mapview/mpflutter_wechat_mapview.dart';

class WXMapView extends StatefulWidget {
  const WXMapView({super.key});

  @override
  State<WXMapView> createState() => _WXMapViewState();
}

class _WXMapViewState extends State<WXMapView> {
  final controller = MPFlutter_Wechat_MapViewController();
  String selectedAddress = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MPFlutterWechatAppShareManager.setAppShareInfo(
      context: context,
      title: "Map Demo",
      query: {"routeName": "/map_demo"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WXMapView'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: MPFlutter_Wechat_MapView(
              controller: controller,
              longitude: 113.347698,
              latitude: 23.100022,
              markers: const [
                {
                  "id": "HeJi",
                  "title": "赫基大厦",
                  "longitude": 113.347698,
                  "latitude": 23.100022,
                },
                {
                  "id": "WeChat",
                  "title": "微信总部",
                  "longitude": 113.324560,
                  "latitude": 23.100100,
                }
              ],
              onMarkerTap: (detail) {
                setState(() {
                  selectedAddress = detail["markerId"];
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('当前选中的地点是: $selectedAddress'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
