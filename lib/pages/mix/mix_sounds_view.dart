import 'package:awesome_project/pages/mix/mix_logic.dart';
import 'package:flutter/material.dart';

import '../../providers/models/gt_music.dart';
import 'package:get/get.dart';

import '../../views/music_item_view.dart';

class MixSoundsView extends StatelessWidget {
  final logic = Get.find<MixLogic>();
  final List<GtMusic> sounds;

  MixSoundsView({super.key, required this.sounds});

  @override
  Widget build(BuildContext context) {
    final itemW = ((Get.width - 6 * 10) / 5).floorToDouble();

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 100),
      itemBuilder: (context, index) {
        final section = sounds[index];
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: itemW,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, bottom: 10),
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
                    .map(
                      (e) => MusicItemView(
                        size: itemW,
                        musicItem: e,
                        onTap: () {
                          logic.selectSound(e);
                        },
                        isPlaying: logic.isPlaying(e),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        );
      },
      itemCount: sounds.length,
    );
  }
}
