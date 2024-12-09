// To parse this JSON data, do
//
//     final sizes = sizesFromJson(jsonString);

import 'dart:convert';

List<Sizes> sizesFromJson(String str) =>
    List<Sizes>.from(json.decode(str).map((x) => Sizes.fromJson(x)));

String sizesToJson(List<Sizes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sizes {
  String id;
  String createdAt;
  String dni;
  String name;
  String description;
  String phone;
  String bankAccount;

  Sizes({
    required this.id,
    required this.createdAt,
    required this.dni,
    required this.name,
    required this.description,
    required this.phone,
    required this.bankAccount,
  });

  Sizes copyWith({
    String? id,
    String? createdAt,
    String? dni,
    String? name,
    String? description,
    String? phone,
    String? bankAccount,
  }) =>
      Sizes(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        dni: dni ?? this.dni,
        name: name ?? this.name,
        description: description ?? this.description,
        phone: phone ?? this.phone,
        bankAccount: bankAccount ?? this.bankAccount,
      );

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        id: json["id"],
        createdAt: json["created_at"],
        dni: json["dni"],
        name: json["name"],
        description: json["description"],
        phone: json["phone"],
        bankAccount: json["bank_account"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "dni": dni,
        "name": name,
        "description": description,
        "phone": phone,
        "bank_account": bankAccount,
      };
}
