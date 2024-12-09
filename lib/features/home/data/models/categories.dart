// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  int id;
  String createdAt;
  String name;

  Categories({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  Categories copyWith({
    int? id,
    String? createdAt,
    String? name,
  }) =>
      Categories(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
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
