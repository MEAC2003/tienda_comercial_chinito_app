// To parse this JSON data, do
//
//     final sizes = sizesFromJson(jsonString);

import 'dart:convert';

List<Sizes> sizesFromJson(String str) =>
    List<Sizes>.from(json.decode(str).map((x) => Sizes.fromJson(x)));

String sizesToJson(List<Sizes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sizes {
  int? id;
  String? createdAt;
  String name;

  Sizes({
    this.id,
    this.createdAt,
    required this.name,
  });

  Sizes copyWith({
    int? id,
    String? createdAt,
    String? name,
  }) =>
      Sizes(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
