import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

abstract class ActionDataSource {
  // Métodos CRUD para Productos
  Future<String?> createProduct(Products product);
  Future<void> updateProduct(Products product);
  Future<void> deleteProduct(String productId);
  Future<List<Products>> getProduct();
  Future<Products> getProductById({required String id});

  Future<void> createInventoryMovement(InventoryMovements movement);
  // Métodos CRUD para Categorías
  Future<void> createCategory(Categories category);
  Future<void> updateCategory(Categories category);
  Future<void> deleteCategory(String categoryId);
  Future<List<Categories>> getCategorie();

  // Métodos CRUD para Tipos de Prenda
  Future<void> createTypeGarment(TypeGarment typeGarment);
  Future<void> updateTypeGarment(TypeGarment typeGarment);
  Future<void> deleteTypeGarment(String typeGarmentId);
  Future<List<TypeGarment>> getTypeGarment();

  // Métodos CRUD para Zonas
  Future<void> createZone(Zones zone);
  Future<void> updateZone(Zones zone);
  Future<void> deleteZone(String zoneId);
  Future<List<Zones>> getZone();

  // Métodos CRUD para Proveedores
  Future<void> createSupplier(Suppliers supplier);
  Future<void> updateSupplier(Suppliers supplier);
  Future<void> deleteSupplier(String supplierId);
  Future<List<Suppliers>> getSupplier();
  Future<Suppliers> getSupplierById({required String id});

  // Métodos CRUD para Escuelas
  Future<void> createSchool(Schools school);
  Future<void> updateSchool(Schools school);
  Future<void> deleteSchool(String schoolId);
  Future<List<Schools>> getSchools();

  // Métodos CRUD para Tamaños
  Future<void> createSize(Sizes size);
  Future<void> updateSize(Sizes size);
  Future<void> deleteSize(String sizeId);
  Future<List<Sizes>> getSize();

  // Métodos CRUD para Sexos
  Future<void> createSex(Sex sex);
  Future<void> updateSex(Sex sex);
  Future<void> deleteSex(String sexId);
  Future<List<Sex>> getSex();

  // Métodos de Usuarios
  Future<List<PublicUser>> getUsers();
  Future<PublicUser> getUserById({required String id});

  // Métodos de Movimientos de Inventario
  Future<List<InventoryMovements>> getInventoryMovements();
}

class SupabaseActionDataSourceImpl implements ActionDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<String?> createProduct(Products product) async {
    try {
      final response = await _supabase
          .from('products')
          .insert(product.toJson())
          .select()
          .single();
      return response['id'] as String;
    } catch (e) {
      print('Error creating product: $e');
      return null;
    }
  }

  @override
  Future<void> updateProduct(Products product) async {
    try {
      if (product.id == null || product.id!.isEmpty) {
        throw Exception('Product ID cannot be null or empty');
      }

      print('Datasource: Updating product with ID: ${product.id}');

      // String comparison for ID
      await _supabase
          .from('products')
          .update(product.toJson())
          .eq('id', product.id.toString());

      print('Datasource: Product update completed for ID: ${product.id}');
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    try {
      await _supabase.from('products').delete().eq('id', productId);
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  @override
  Future<void> createCategory(Categories category) async {
    try {
      await _supabase.from('categories').upsert(category.toJson());
    } catch (e) {
      print('Error creating category: $e');
      rethrow;
    }
  }

  Future<void> updateCategory(Categories category) async {
    try {
      if (category.id == null) {
        throw Exception('Category ID cannot be null');
      }
      await _supabase
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id.toString());
    } catch (e) {
      print('Error updating category: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _supabase.from('categories').delete().eq('id', categoryId);
    } catch (e) {
      print('Error deleting category: $e');
      rethrow;
    }
  }

  @override
  Future<void> createTypeGarment(TypeGarment typeGarment) async {
    try {
      await _supabase.from('type_garment').upsert(typeGarment.toJson());
    } catch (e) {
      print('Error creating type garment: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTypeGarment(TypeGarment typeGarment) async {
    try {
      if (typeGarment.id == null || typeGarment.id!.isEmpty) {
        throw Exception('Type Garment ID cannot be null or empty');
      }
      await _supabase
          .from('type_garment')
          .update(typeGarment.toJson())
          .eq('id', typeGarment.id.toString());
    } catch (e) {
      print('Error updating type garment: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTypeGarment(String typeGarmentId) async {
    try {
      await _supabase.from('type_garment').delete().eq('id', typeGarmentId);
    } catch (e) {
      print('Error deleting type garment: $e');
      rethrow;
    }
  }

  @override
  Future<void> createZone(Zones zone) async {
    try {
      await _supabase.from('zones').upsert(zone.toJson());
    } catch (e) {
      print('Error creating zone: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateZone(Zones zone) async {
    try {
      if (zone.id == null || zone.id!.isEmpty) {
        throw Exception('Zone ID cannot be null or empty');
      }
      await _supabase
          .from('zones')
          .update(zone.toJson())
          .eq('id', zone.id.toString());
    } catch (e) {
      print('Error updating zone: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteZone(String zoneId) async {
    try {
      await _supabase.from('zones').delete().eq('id', zoneId);
    } catch (e) {
      print('Error deleting zone: $e');
      rethrow;
    }
  }

  @override
  Future<void> createSupplier(Suppliers supplier) async {
    try {
      await _supabase.from('suppliers').upsert(supplier.toJson());
    } catch (e) {
      print('Error creating supplier: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateSupplier(Suppliers supplier) async {
    try {
      if (supplier.id == null || supplier.id!.isEmpty) {
        throw Exception('Supplier ID cannot be null or empty');
      }
      await _supabase
          .from('suppliers')
          .update(supplier.toJson())
          .eq('id', supplier.id.toString());
    } catch (e) {
      print('Error updating supplier: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteSupplier(String supplierId) async {
    try {
      await _supabase.from('suppliers').delete().eq('id', supplierId);
    } catch (e) {
      print('Error deleting supplier: $e');
      rethrow;
    }
  }

  @override
  Future<void> createSchool(Schools school) async {
    try {
      await _supabase.from('schools').upsert(school.toJson());
    } catch (e) {
      print('Error creating school: $e');
      rethrow;
    }
  }

  @override
  Future<void> createInventoryMovement(InventoryMovements movement) async {
    try {
      await _supabase.from('inventory_movements').insert(movement.toJson());
    } catch (e) {
      print('Error creando movimiento de inventario: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateSchool(Schools school) async {
    try {
      if (school.id == null || school.id!.isEmpty) {
        throw Exception('School ID cannot be null or empty');
      }
      await _supabase
          .from('schools')
          .update(school.toJson())
          .eq('id', school.id.toString());
    } catch (e) {
      print('Error updating school: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteSchool(String schoolId) async {
    try {
      await _supabase.from('schools').delete().eq('id', schoolId);
    } catch (e) {
      print('Error deleting school: $e');
      rethrow;
    }
  }

  @override
  Future<void> createSize(Sizes size) async {
    try {
      await _supabase.from('sizes').upsert(size.toJson());
    } catch (e) {
      print('Error creating size: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateSize(Sizes size) async {
    try {
      if (size.id == null) {
        throw Exception('Size ID cannot be null or empty');
      }
      await _supabase
          .from('sizes')
          .update(size.toJson())
          .eq('id', size.id.toString());
    } catch (e) {
      print('Error updating size: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteSize(String sizeId) async {
    try {
      await _supabase.from('sizes').delete().eq('id', sizeId);
    } catch (e) {
      print('Error deleting size: $e');
      rethrow;
    }
  }

  @override
  Future<void> createSex(Sex sex) async {
    try {
      await _supabase.from('sex').upsert(sex.toJson());
    } catch (e) {
      print('Error creating: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateSex(Sex sex) async {
    try {
      if (sex.id == 0) {
        throw Exception('Sex ID cannot be zero');
      }
      await _supabase
          .from('sex')
          .update(sex.toJson())
          .eq('id', sex.id.toString());
    } catch (e) {
      print('Error updating size: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteSex(String sexId) async {
    try {
      await _supabase.from('sex').delete().eq('id', sexId);
    } catch (e) {
      print('Error deleting size: $e');
      rethrow;
    }
  }

  @override
  Future<List<Products>> getProduct() async {
    try {
      final response = await _supabase.from('products').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Products.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getProduct: $e');
      rethrow;
    }
  }

  @override
  Future<Products> getProductById({required String id}) async {
    try {
      final response =
          await _supabase.from('products').select().eq('id', id).single();
      return Products.fromJson(response);
    } catch (e) {
      print('Error fetching getProductById: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovements>> getInventoryMovements() async {
    try {
      final response = await _supabase.from('inventory_movements').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => InventoryMovements.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getInventoryMovements: $e');
      rethrow;
    }
  }

  @override
  Future<List<Categories>> getCategorie() async {
    try {
      final response = await _supabase.from('categories').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Categories.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getCategorie: $e');
      rethrow;
    }
  }

  @override
  Future<List<TypeGarment>> getTypeGarment() async {
    try {
      final response = await _supabase.from('type_garment').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => TypeGarment.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getTypeGarment: $e');
      rethrow;
    }
  }

  @override
  Future<List<Zones>> getZone() async {
    try {
      final response = await _supabase.from('zones').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Zones.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getZone: $e');
      rethrow;
    }
  }

  @override
  Future<List<Schools>> getSchools() async {
    try {
      final response = await _supabase.from('schools').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Schools.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getSchools: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sizes>> getSize() async {
    try {
      final response = await _supabase.from('sizes').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Sizes.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getSize: $e');
      rethrow;
    }
  }

  @override
  Future<List<Suppliers>> getSupplier() async {
    try {
      final response = await _supabase.from('suppliers').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Suppliers.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getSupplier: $e');
      rethrow;
    }
  }

  @override
  Future<PublicUser> getUserById({required String id}) async {
    try {
      final response =
          await _supabase.from('public_users').select().eq('id', id).single();
      return PublicUser.fromJson(response);
    } catch (e) {
      print('Error fetching getUserById: $e');
      rethrow;
    }
  }

  @override
  Future<List<PublicUser>> getUsers() async {
    try {
      final response = await _supabase.from('public_users').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => PublicUser.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getUsers: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sex>> getSex() async {
    try {
      final response = await _supabase.from('sex').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Sex.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getSex: $e');
      rethrow;
    }
  }

  @override
  Future<Suppliers> getSupplierById({required String id}) async {
    try {
      final response =
          await _supabase.from('suppliers').select().eq('id', id).single();
      return Suppliers.fromJson(response);
    } catch (e) {
      print('Error fetching getSupplierById: $e');
      rethrow;
    }
  }
}
