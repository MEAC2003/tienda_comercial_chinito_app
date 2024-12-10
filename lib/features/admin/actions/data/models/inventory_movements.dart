// To parse this JSON data, do
//
//     final inventoryMovements = inventoryMovementsFromJson(jsonString);

import 'dart:convert';

List<InventoryMovements> inventoryMovementsFromJson(String str) =>
    List<InventoryMovements>.from(
        json.decode(str).map((x) => InventoryMovements.fromJson(x)));

String inventoryMovementsToJson(List<InventoryMovements> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InventoryMovements {
  String? id;
  String createdAt;
  String productId;
  int movementTypeId;
  int quantity;
  String userId;

  InventoryMovements({
    this.id,
    required this.createdAt,
    required this.productId,
    required this.movementTypeId,
    required this.quantity,
    required this.userId,
  });

  InventoryMovements copyWith({
    String? id,
    String? createdAt,
    String? productId,
    int? movementTypeId,
    int? quantity,
    String? userId,
  }) =>
      InventoryMovements(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        productId: productId ?? this.productId,
        movementTypeId: movementTypeId ?? this.movementTypeId,
        quantity: quantity ?? this.quantity,
        userId: userId ?? this.userId,
      );

  factory InventoryMovements.fromJson(Map<String, dynamic> json) =>
      InventoryMovements(
        id: json["id"],
        createdAt: json["created_at"],
        productId: json["product_id"],
        movementTypeId: json["movement_type_id"],
        quantity: json["quantity"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "movement_type_id": movementTypeId,
        "quantity": quantity,
        "user_id": userId,
      };
}
