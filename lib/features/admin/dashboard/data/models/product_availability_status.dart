// To parse this JSON data, do
//
//     final productAvailabilityStatus = productAvailabilityStatusFromJson(jsonString);

import 'dart:convert';

List<ProductAvailabilityStatus> productAvailabilityStatusFromJson(String str) =>
    List<ProductAvailabilityStatus>.from(
        json.decode(str).map((x) => ProductAvailabilityStatus.fromJson(x)));

String productAvailabilityStatusToJson(List<ProductAvailabilityStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductAvailabilityStatus {
  int id;
  String createdAt;
  String statusName;

  ProductAvailabilityStatus({
    required this.id,
    required this.createdAt,
    required this.statusName,
  });

  ProductAvailabilityStatus copyWith({
    int? id,
    String? createdAt,
    String? statusName,
  }) =>
      ProductAvailabilityStatus(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        statusName: statusName ?? this.statusName,
      );

  factory ProductAvailabilityStatus.fromJson(Map<String, dynamic> json) =>
      ProductAvailabilityStatus(
        id: json["id"],
        createdAt: json["created_at"],
        statusName: json["status_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "status_name": statusName,
      };
}
