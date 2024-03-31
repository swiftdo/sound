import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/views/filling_slider.dart';
import 'package:awesome_project/views/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'mix_logic.dart';
import 'package:get/get.dart';

class MixVolumesView extends StatelessWidget {
  final logic = Get.find<MixLogic>();

  MixVolumesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 44;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      child: Wrap(
        spacing: 16,
        children: logic.state.activeSound.items.map((soundItem) {
          return Container(
            child: Stack(
              children: [
                FillingSlider(
                  width: size,
                  height: 200,
                  direction: FillingSliderDirection.vertical,
                  initialValue: soundItem.volume,
                  onFinish: (volume) {
                    logic.updateSoundVolume(
                      soundItem: soundItem,
                      newVolume: volume,
                    );
                  },
                  onChange: (newVolume, oldVolume) {
                    logic.updateSoundVolume(
                      soundItem: soundItem,
                      newVolume: newVolume,
                    );
                    print("$newVolume $oldVolume");
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    child: SvgPicture.network(
                      soundItem.icon.url,
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
