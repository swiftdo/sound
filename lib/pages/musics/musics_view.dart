import 'package:awesome_project/constants.dart';
import 'package:awesome_project/providers/models/gt_music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/active_sound.dart';
import '../../models/group_sound.dart';
import '../../views/music_item_view.dart';
import '../../views/music_mix_item_view.dart';
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
              itemCount: body.music.length + 1,
              tabBuilder: (context, index, active) {
                final tabName = index < body.music.length
                    ? body.music[index].name
                    : Constants.mixName;
                return Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    tabName,
                    style: TextStyle(
                      color: active ? Colors.black : Colors.grey,
                      fontSize: 14,
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
                if (index < body.music.length) {
                  return _buildSingleSection(
                      section: body.music[index], itemW: itemW);
                } else {
                  final mixSection = state.mixList;
                  return _buildMixSection(mixSection, itemW);
                }
              });
        },
      ),
    );
  }

  Widget _buildMixSection(List<GroupSound> mixSection, double itemW) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: itemW,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              Constants.mixName,
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
            children: mixSection
                .map((e) => MusicMixItemView(
                      size: itemW,
                      musicItem: e,
                      onTap: () {
                        Get.back(result: ActiveSound.fromGroupSound(e));
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSingleSection(
      {required double itemW, required GtMusic section}) {
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
                      onTap: () {
                        Get.back(result: ActiveSound.fromMusic(e));
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
