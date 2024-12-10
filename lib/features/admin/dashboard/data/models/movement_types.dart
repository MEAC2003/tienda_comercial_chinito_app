// To parse this JSON data, do
//
//     final movementTypes = movementTypesFromJson(jsonString);

import 'dart:convert';

List<MovementTypes> movementTypesFromJson(String str) => List<MovementTypes>.from(json.decode(str).map((x) => MovementTypes.fromJson(x)));

String movementTypesToJson(List<MovementTypes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MovementTypes {
    int id;
    String createdAt;
    String typeName;
    String description;

    MovementTypes({
        required this.id,
        required this.createdAt,
        required this.typeName,
        required this.description,
    });

    MovementTypes copyWith({
        int? id,
        String? createdAt,
        String? typeName,
        String? description,
    }) => 
        MovementTypes(
            id: id ?? this.id,
            createdAt: createdAt ?? this.createdAt,
            typeName: typeName ?? this.typeName,
            description: description ?? this.description,
        );

    factory MovementTypes.fromJson(Map<String, dynamic> json) => MovementTypes(
        id: json["id"],
        createdAt: json["created_at"],
        typeName: json["type_name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "type_name": typeName,
        "description": description,
    };
}
