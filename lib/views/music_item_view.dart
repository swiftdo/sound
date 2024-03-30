import 'package:awesome_project/extensions.dart';
import 'package:awesome_project/providers/models/gt_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MusicItemView extends StatelessWidget {
  final GtMusicItem musicItem;
  final double size;
  final VoidCallback onTap;
  final bool isPlaying;

  const MusicItemView({
    super.key,
    required this.musicItem,
    required this.size,
    required this.onTap,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(size / 2),
          color: Colors.white,
        ),
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.network(
                  musicItem.icon.url,
                  width: 25,
                  height: 25,
                ),
                if (musicItem.hideName == null ||
                    musicItem.hideName == false) ...[
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
            if (isPlaying)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(size / 2),
                ),
                height: size,
                width: size,
                alignment: Alignment.center,
                child: Icon(
                  Icons.multitrack_audio,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
