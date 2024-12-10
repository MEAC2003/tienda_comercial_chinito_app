import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/zones.dart';

abstract class DashboardDataSource {
  Future<List<Products>> getProduct();
  Future<Products> getProductById({required int id});
  Future<List<Categories>> getCategorie();
  Future<List<TypeGarment>> getTypeGarment();
  Future<List<Schools>> getSchools();
  Future<List<Sex>> getSex();
  Future<List<Sizes>> getSize();
  Future<List<Suppliers>> getSuppliers();
  Future<List<Zones>> getZones();
  Future<List<InventoryMovements>> getInventoryMovements();
}

class SupabaseDashboardDataSourceImpl implements DashboardDataSource {
  final _supabase = Supabase.instance.client;

  @override
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
  Future<List<Suppliers>> getSuppliers() async {
    try {
      final response = await _supabase.from('suppliers').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Suppliers.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getSuppliers: $e');
      rethrow;
    }
  }

  @override
  Future<List<Zones>> getZones() async {
    try {
      final response = await _supabase.from('zones').select();
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Zones.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching getZones: $e');
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
}
