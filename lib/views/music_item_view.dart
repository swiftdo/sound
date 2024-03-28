import 'package:awesome_project/providers/models/gt_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MusicItemView extends StatelessWidget {
  final String baseUrl;
  final GtMusicItem musicItem;
  final double size;

  const MusicItemView(
      {super.key,
      required this.musicItem,
      required this.size,
      required this.baseUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      height: size,
      width: size,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.network(
            baseUrl + musicItem.icon,
            width: 25,
            height: 25,
          ),
          if (musicItem.hideName == null || musicItem.hideName == false) ...[
            SizedBox(
              height: 3,
            ),
            Text(
              musicItem.name,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
