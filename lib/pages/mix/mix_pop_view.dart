import 'dart:math';

import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/views/state_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'mix_pop_logic.dart';

class MixPopView extends StatefulWidget {
  final List<String> paths;
  const MixPopView({super.key, required this.paths});

  @override
  State<MixPopView> createState() => _MixPopViewState();
}

class _MixPopViewState extends State<MixPopView> {
  final logic = Get.put(MixPopLogic());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: GestureDetector(
              onTap: () async {
                final itemW = (Get.width - 6 * 10) / 5;
                final path = await Get.bottomSheet<String>(
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 10,
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: widget.paths
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  Get.back(result: e);
                                },
                                child: Container(
                                  width: itemW,
                                  height: itemW,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(itemW / 2),
                                  ),
                                  child: SvgPicture.network(
                                    e.url,
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                );

                if (path != null) {
                  logic.updatePath(path);
                }
              },
              child: GetBuilder(
                builder: (MixPopLogic logic) {
                  final iconPath = logic.state.path;
                  if (iconPath == null) {
                    return Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.grey,
                    );
                  } else {
                    return SvgPicture.network(
                      iconPath.url,
                      width: 40,
                      height: 40,
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: '输入组合名称',
                border: InputBorder.none,
                counterText: "",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                isDense: true,
              ),
              onChanged: (text) {
                logic.updateTitle(text);
              },
              maxLength: 5,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GetBuilder(builder: (MixPopLogic logic) {
            final isHi = logic.state.path != null &&
                (logic.state.title != null && logic.state.title!.isNotEmpty);

            return StateButton(
              title: "保存",
              width: 200,
              height: 44,
              borderColor: isHi ? Colors.black : Colors.grey,
              textColor: isHi ? Colors.black : Colors.grey,
              onTap: () {
                if (logic.state.path == null) {
                  Get.snackbar(
                    "提示",
                    "请先选择图标",
                    backgroundColor: Colors.white,
                    margin: EdgeInsets.all(20),
                  );
                  return;
                }
                if (logic.state.title == null || logic.state.title!.isEmpty) {
                  Get.snackbar(
                    "提示",
                    "请先输入组合名称",
                    backgroundColor: Colors.white,
                    margin: EdgeInsets.all(20),
                  );
                  return;
                }
                Get.back(result: logic.state);
              },
            );
          }),
        ],
      ),
    );
  }
}
