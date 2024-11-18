// To parse this JSON data, do
//
//     final publicUser = publicUserFromJson(jsonString);

import 'dart:convert';

List<PublicUser> publicUserFromJson(String str) =>
    List<PublicUser>.from(json.decode(str).map((x) => PublicUser.fromJson(x)));

String publicUserToJson(List<PublicUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicUser {
  String id;
  String createdAt;
  String email;
  String fullName;
  String role;

  PublicUser({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.fullName,
    required this.role,
  });

  PublicUser copyWith({
    String? id,
    String? createdAt,
    String? email,
    String? fullName,
    String? role,
  }) =>
      PublicUser(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        role: role ?? this.role,
      );

  factory PublicUser.fromJson(Map<String, dynamic> json) => PublicUser(
        id: json["id"],
        createdAt: json["created_at"],
        email: json["email"],
        fullName: json["full_name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "email": email,
        "full_name": fullName,
        "role": role,
      };
}
