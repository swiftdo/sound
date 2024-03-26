class GtMusicItem {
  final String name;
  final String path;
  final String icon;

  GtMusicItem({required this.name, required this.path, required this.icon});

  GtMusicItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        path = json['path'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {'name': name, 'path': path, 'icon': icon};
}

class GtMusic {
  final String name;
  final String icon;
  final List<GtMusicItem> items;

  GtMusic({required this.name, required this.icon, required this.items});

  GtMusic.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icon = json['icon'],
        items = (json['items'] as List)
            .map((e) => GtMusicItem.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'items': items.map((e) => e.toJson()).toList()
      };
}
