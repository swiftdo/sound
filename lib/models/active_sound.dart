import '../providers/models/gt_music.dart';
import 'group_sound.dart';

enum ActiveSoundType {
  single,
  group;

  int toInt() {
    return this.index;
  }

  static ActiveSoundType fromInt(int index) {
    return ActiveSoundType.values[index];
  }
}

// 激活音乐
class ActiveSound {
  final String name; // 名字
  final String icon; // icon
  final String cover;
  final ActiveSoundType type;
  final List<GtMusicItem> items; // 音乐组合

  ActiveSound({
    required this.name,
    required this.icon,
    required this.cover,
    this.items = const [],
    required this.type,
  });

  ActiveSound.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icon = json['icon'],
        cover = json['cover'],
        items = (json['items'] as List)
            .map((e) => GtMusicItem.fromJson(e))
            .toList(),
        type = ActiveSoundType.fromInt(json['type'] ?? 0);

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'cover': cover,
        'type': type.toInt(),
        'items': items.map((e) => e.toJson()).toList()
      };

  ActiveSound.fromMusic(GtMusicItem musicItem)
      : name = musicItem.name,
        icon = musicItem.icon,
        cover = musicItem.cover,
        type = ActiveSoundType.single,
        items = [musicItem];

  ActiveSound.fromGroupSound(GroupSound groupSound)
      : name = groupSound.name,
        icon = groupSound.icon,
        cover = groupSound.cover,
        type = ActiveSoundType.group,
        items = groupSound.items;
}
