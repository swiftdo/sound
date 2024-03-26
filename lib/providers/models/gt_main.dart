import 'gt_music.dart';

class GtMain {
  final String musicBase;
  final List<GtMusic> music;

  GtMain({required this.musicBase, required this.music});

  GtMain.fromJson(Map<String, dynamic> json)
      : musicBase = json['music_base'],
        music =
            (json['music'] as List).map((e) => GtMusic.fromJson(e)).toList();

  Map<String, dynamic> toJson() =>
      {'music_base': musicBase, 'music': music.map((e) => e.toJson()).toList()};
}
