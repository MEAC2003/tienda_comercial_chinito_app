import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/type_garment.dart';

abstract class ProductDataSource {
  Future<List<Products>> getProduct();
  Future<Products> getProductById({required int id});
  Future<List<Categories>> getCategorie();
  Future<List<TypeGarment>> getTypeGarment();
  Future<List<Schools>> getSchools();
  Future<List<Sex>> getSex();
  Future<List<Sizes>> getSize();
  Future<void> createInventoryMovement(InventoryMovements movement);
  // Nuevo método para actualizar el stock
  Future<void> updateProductStock(String productId, int newStock);
}

class SupabaseProductDataSourceImpl implements ProductDataSource {
  final _supabase = Supabase.instance.client;

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
  Future<Products> getProductById({required int id}) async {
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
  Future<List<Sizes>> getSize() async {
    try {
      final response = await _supabase.from('sizes').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Sizes.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching  getSize: $e');
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
  Future<void> updateProductStock(String productId, int newStock) async {
    try {
      await _supabase
          .from('products')
          .update({'current_stock': newStock}).eq('id', productId);
    } catch (e) {
      print('Error actualizando el stock del producto: $e');
      rethrow;
    }
  }
}
