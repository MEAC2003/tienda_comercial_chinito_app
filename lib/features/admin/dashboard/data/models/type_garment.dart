// To parse this JSON data, do
//
//     final typeGarment = typeGarmentFromJson(jsonString);

import 'dart:convert';

List<TypeGarment> typeGarmentFromJson(String str) => List<TypeGarment>.from(
    json.decode(str).map((x) => TypeGarment.fromJson(x)));

String typeGarmentToJson(List<TypeGarment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeGarment {
  String id;
  String createdAt;
  String name;

  TypeGarment({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  TypeGarment copyWith({
    String? id,
    String? createdAt,
    String? name,
  }) =>
      TypeGarment(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );

  factory TypeGarment.fromJson(Map<String, dynamic> json) => TypeGarment(
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
