import 'package:awesome_project/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/group_sound.dart';

class MusicMixItemView extends StatelessWidget {
  final double size;
  final VoidCallback onTap;
  final bool isPlaying;
  final GroupSound musicItem;

  const MusicMixItemView({
    super.key,
    required this.size,
    required this.onTap,
    this.isPlaying = false,
    required this.musicItem,
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
                SizedBox(
                  height: 3,
                ),
                Text(
                  musicItem.name,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
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
