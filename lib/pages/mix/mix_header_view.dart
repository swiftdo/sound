import 'package:awesome_project/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'mix_logic.dart';
import 'mix_state.dart';

class MixHeaderView extends StatelessWidget {
  final logic = Get.find<MixLogic>();
  final VoidCallback onTap;

  MixHeaderView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double size = 50;
    return Container(
      height: Get.height / 2 - 100,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          children: logic.state.activeSound.items.map((musicItem) {
            int index = logic.state.activeSound.items.indexOf(musicItem);
            return AnimatedPadding(
              padding: EdgeInsets.only(
                  left: logic.state.mixPageState == MixPageState.sound
                      ? (index * (size + 10))
                      : index * size * 0.8),
              duration: Duration(
                milliseconds: 250,
              ),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size / 2),
                  ),
                  height: size,
                  width: size,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.network(
                        musicItem.icon.url,
                        width: 20,
                        height: 20,
                      ),
                      if (musicItem.hideName == null ||
                          musicItem.hideName == false) ...[
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          musicItem.name,
                          style: TextStyle(
                            fontSize: 6,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
