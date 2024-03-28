import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/music_item_view.dart';
import 'musics_logic.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

class MusicsPage extends StatelessWidget {
  MusicsPage({Key? key}) : super(key: key);

  final logic = Get.find<MusicsLogic>();
  final state = Get.find<MusicsLogic>().state;

  @override
  Widget build(BuildContext context) {
    final itemW = ((Get.width - 5 * 10) / 4).floorToDouble();
    return Scaffold(
      appBar: AppBar(
        title: Text("声音"),
      ),
      body: GetBuilder(
        builder: (MusicsLogic logic) {
          final body = logic.state.body;
          if (body == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ScrollableListTabScroller(
              padding: EdgeInsets.all(10).copyWith(bottom: 300),
              itemCount: body.music.length,
              tabBuilder: (context, index, active) {
                return Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    body.music[index].name,
                    style: TextStyle(
                      color: active ? Colors.black : Colors.grey,
                      fontSize: active ? 16 : 14,
                    ),
                  ),
                );
              },
              headerContainerBuilder: (context, child) {
                return SizedBox(
                  child: child,
                  height: 40,
                );
              },
              itemBuilder: (context, index) {
                final section = body.music[index];

                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: itemW,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          section.name,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: section.items
                            .map((e) => MusicItemView(
                                  size: itemW,
                                  musicItem: e,
                                  baseUrl: body.musicBase,
                                ))
                            .toList(),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
