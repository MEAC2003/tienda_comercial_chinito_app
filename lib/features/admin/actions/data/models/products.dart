// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String id;
  String createdAt;
  String name;
  List<String> imageUrl;
  int salePrice;
  int currentStock;
  int minimumStock;
  String typeGarmentId;
  String supplierId;
  String schoolId;
  int sizeId;
  int categoryId;
  int sexId;
  bool isAvailable;

  Products({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.imageUrl,
    required this.salePrice,
    required this.currentStock,
    required this.minimumStock,
    required this.typeGarmentId,
    required this.supplierId,
    required this.schoolId,
    required this.sizeId,
    required this.categoryId,
    required this.sexId,
    required this.isAvailable,
  });

  Products copyWith({
    String? id,
    String? createdAt,
    String? name,
    List<String>? imageUrl,
    int? salePrice,
    int? currentStock,
    int? minimumStock,
    String? typeGarmentId,
    String? supplierId,
    String? schoolId,
    int? sizeId,
    int? categoryId,
    int? sexId,
    bool? isAvailable,
  }) =>
      Products(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        salePrice: salePrice ?? this.salePrice,
        currentStock: currentStock ?? this.currentStock,
        minimumStock: minimumStock ?? this.minimumStock,
        typeGarmentId: typeGarmentId ?? this.typeGarmentId,
        supplierId: supplierId ?? this.supplierId,
        schoolId: schoolId ?? this.schoolId,
        sizeId: sizeId ?? this.sizeId,
        categoryId: categoryId ?? this.categoryId,
        sexId: sexId ?? this.sexId,
        isAvailable: isAvailable ?? this.isAvailable,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
        imageUrl: List<String>.from(json["image_url"].map((x) => x)),
        salePrice: json["sale_price"],
        currentStock: json["current_stock"],
        minimumStock: json["minimum_stock"],
        typeGarmentId: json["type_garment_id"],
        supplierId: json["supplier_id"],
        schoolId: json["school_id"],
        sizeId: json["size_id"],
        categoryId: json["category_id"],
        sexId: json["sex_id"],
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "name": name,
        "image_url": List<dynamic>.from(imageUrl.map((x) => x)),
        "sale_price": salePrice,
        "current_stock": currentStock,
        "minimum_stock": minimumStock,
        "type_garment_id": typeGarmentId,
        "supplier_id": supplierId,
        "school_id": schoolId,
        "size_id": sizeId,
        "category_id": categoryId,
        "sex_id": sexId,
        "is_available": isAvailable,
      };
}
