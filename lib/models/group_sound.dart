// 组合音乐
import '../providers/models/gt_music.dart';

class GroupSound {
  final String name; // 名字
  final String icon; // icon
  final String cover;
  final String id; // uuid 吧
  final List<GtMusicItem> items; // 音乐组合

  GroupSound({
    required this.name,
    required this.icon,
    required this.cover,
    required this.id,
    this.items = const [],
  });

  GroupSound.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icon = json['icon'],
        cover = json['cover'],
        id = json['id'],
        items = (json['items'] as List)
            .map((e) => GtMusicItem.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'cover': cover,
        'id': id,
        'items': items.map((e) => e.toJson()).toList()
      };
}
