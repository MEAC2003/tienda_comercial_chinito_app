// To parse this JSON data, do
//
//     final sizes = sizesFromJson(jsonString);

import 'dart:convert';

List<Suppliers> sizesFromJson(String str) =>
    List<Suppliers>.from(json.decode(str).map((x) => Suppliers.fromJson(x)));

String sizesToJson(List<Suppliers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Suppliers {
  String? id;
  String? createdAt;
  String dni;
  String name;
  String description;
  String phone;
  String bankAccount;

  Suppliers({
    this.id,
    this.createdAt,
    required this.dni,
    required this.name,
    required this.description,
    required this.phone,
    required this.bankAccount,
  });

  Suppliers copyWith({
    String? id,
    String? createdAt,
    String? dni,
    String? name,
    String? description,
    String? phone,
    String? bankAccount,
  }) =>
      Suppliers(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        dni: dni ?? this.dni,
        name: name ?? this.name,
        description: description ?? this.description,
        phone: phone ?? this.phone,
        bankAccount: bankAccount ?? this.bankAccount,
      );

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
        id: json["id"],
        createdAt: json["created_at"],
        dni: json["dni"],
        name: json["name"],
        description: json["description"],
        phone: json["phone"],
        bankAccount: json["bank_account"],
      );

  Map<String, dynamic> toJson() => {
        "dni": dni,
        "name": name,
        "description": description,
        "phone": phone,
        "bank_account": bankAccount,
      };
}
