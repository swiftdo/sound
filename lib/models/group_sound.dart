// 组合音乐
import '../providers/models/gt_music.dart';

class GroupSound {
  String? name; // 名字
  String? icon; // icon
  String? cover;
  String? id; // uuid 吧
  List<GtMusicItem> items; // 音乐组合

  GroupSound({
    this.name,
    this.icon,
    this.cover,
    this.id,
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
