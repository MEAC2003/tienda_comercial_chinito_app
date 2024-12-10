// To parse this JSON data, do
//
//     final schools = schoolsFromJson(jsonString);

import 'dart:convert';

List<Schools> schoolsFromJson(String str) =>
    List<Schools>.from(json.decode(str).map((x) => Schools.fromJson(x)));

String schoolsToJson(List<Schools> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Schools {
  String? id;
  String? createdAt;
  String name;
  String level;
  String zoneId;

  Schools({
    this.id,
    this.createdAt,
    required this.name,
    required this.level,
    required this.zoneId,
  });

  Schools copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? level,
    String? zoneId,
  }) =>
      Schools(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        level: level ?? this.level,
        zoneId: zoneId ?? this.zoneId,
      );

  factory Schools.fromJson(Map<String, dynamic> json) => Schools(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
        level: json["level"],
        zoneId: json["zone_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level,
        "zone_id": zoneId,
      };
}
