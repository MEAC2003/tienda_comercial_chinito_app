// To parse this JSON data, do
//
//     final zones = zonesFromJson(jsonString);

import 'dart:convert';

List<Zones> zonesFromJson(String str) =>
    List<Zones>.from(json.decode(str).map((x) => Zones.fromJson(x)));

String zonesToJson(List<Zones> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Zones {
  String? id;
  String? createdAt;
  String name;

  Zones({
    this.id,
    this.createdAt,
    required this.name,
  });

  Zones copyWith({
    String? id,
    String? createdAt,
    String? name,
  }) =>
      Zones(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory Zones.fromJson(Map<String, dynamic> json) => Zones(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
