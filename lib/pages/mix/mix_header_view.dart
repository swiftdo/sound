import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/models/active_sound.dart';
import 'package:awesome_project/pages/mix/mix_pop_state.dart';
import 'package:awesome_project/pages/mix/mix_pop_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../views/state_button.dart';
import 'mix_logic.dart';
import 'mix_state.dart';

class MixHeaderView extends StatelessWidget {
  final logic = Get.find<MixLogic>();
  final VoidCallback onTap;

  MixHeaderView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double size = 50;
    final bool isEmpty = logic.state.activeSound.items.isEmpty;
    return Container(
      height: Get.height / 2 - 100,
      child: Stack(
        children: [
          isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Text("请从下方选择音乐"),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: logic.state.activeSound.items.map((musicItem) {
                      int index =
                          logic.state.activeSound.items.indexOf(musicItem);
                      return AnimatedPadding(
                        padding: EdgeInsets.only(
                            left:
                                logic.state.mixPageState == MixPageState.volume
                                    ? (index * (size + 6))
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
          Positioned(
            right: 10,
            top: 10,
            child: StateButton(
              title: '保存',
              width: 60,
              height: 30,
              borderColor: isEmpty ? Colors.grey : Colors.black,
              textColor: isEmpty ? Colors.grey : Colors.black,
              onTap: () async {
                if (isEmpty) {
                  return;
                }

                final result = await Get.dialog<MixPopState>(
                  Dialog(
                    child: MixPopView(
                      paths: logic.state.body?.icons ?? [],
                    ),
                  ),
                );

                if (result != null) {
                  // 保存到本地
                  final group = logic.saveMix(result);
                  Get.back(result: ActiveSound.fromGroupSound(group));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
