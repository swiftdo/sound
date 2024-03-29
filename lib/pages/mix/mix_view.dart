import 'package:awesome_project/pages/mix/mix_sounds_view.dart';
import 'package:awesome_project/pages/mix/mix_volumes_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/keep_alive_wrapper.dart';
import 'mix_logic.dart';

// 声音混合
class MixPage extends StatefulWidget {
  MixPage({Key? key}) : super(key: key);

  @override
  State<MixPage> createState() => _MixPageState();
}

class _MixPageState extends State<MixPage> with SingleTickerProviderStateMixin {
  final logic = Get.find<MixLogic>();

  final state = Get.find<MixLogic>().state;

  late TabController _tabController;

  List tabs = ["声音", "音量"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('混音'),
      ),
      body: GetBuilder(
        builder: (MixLogic logic) {
          final body = logic.state.body;
          if (body == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Container(
                height: Get.height / 2 - 100,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset.zero,
                          blurRadius: 15,
                        )
                      ]),
                  child: Column(
                    children: [
                      TabBar(
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        controller: _tabController,
                        tabs: tabs.map((e) => Tab(text: e)).toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          //构建
                          controller: _tabController,
                          children: [
                            KeepAliveWrapper(
                                child: MixSoundsView(
                              sounds: body.music,
                            )),
                            KeepAliveWrapper(child: MixVolumesView()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
