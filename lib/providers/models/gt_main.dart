import 'gt_music.dart';

class GtMain {
  final String musicBase;
  final List<GtMusic> music;
  final List<String> icons;

  GtMain({required this.musicBase, required this.music, required this.icons});

  GtMain.fromJson(Map<String, dynamic> json)
      : musicBase = json['music_base'],
        icons = (json['icons'] as List).map((e) => e.toString()).toList(),
        music =
            (json['music'] as List).map((e) => GtMusic.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        'music_base': musicBase,
        'music': music.map((e) => e.toJson()).toList(),
        'icons': icons,
      };
}
