// To parse this JSON data, do
//
//     final sex = sexFromJson(jsonString);

import 'dart:convert';

List<Sex> sexFromJson(String str) =>
    List<Sex>.from(json.decode(str).map((x) => Sex.fromJson(x)));

String sexToJson(List<Sex> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sex {
  int id;
  String createdAt;
  String name;

  Sex({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  Sex copyWith({
    int? id,
    String? createdAt,
    String? name,
  }) =>
      Sex(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory Sex.fromJson(Map<String, dynamic> json) => Sex(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "name": name,
      };
}
