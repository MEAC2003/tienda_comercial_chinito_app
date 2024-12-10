import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';

abstract class ActionDataSource {
  //Crear un producto
  Future<void> createProduct(Products product);
  //Actualizar un producto
  Future<void> updateProduct(Products product);
  //Eliminar un producto
  Future<void> deleteProduct(String productId);
  // crear una categoria
  Future<void> createCategory(Categories category);
  //Actualizar una categoria
  Future<void> updateCategory(Categories category);
  //Eliminar una categoria
  Future<void> deleteCategory(String categoryId);
  // crear un tipo de prenda
  Future<void> createTypeGarment(TypeGarment typeGarment);
  //Actualizar un tipo de prenda
  Future<void> updateTypeGarment(TypeGarment typeGarment);
  //Eliminar un tipo de prenda
  Future<void> deleteTypeGarment(String typeGarmentId);
  // crear una zona
  Future<void> createZone(Zones zone);
  //Actualizar una zona
  Future<void> updateZone(Zones zone);
  //Eliminar una zona
  Future<void> deleteZone(String zoneId);
  // crear un proveedor
  Future<void> createSupplier(Suppliers supplier);
  //Actualizar un proveedor
  Future<void> updateSupplier(Suppliers supplier);
  //Eliminar un proveedor
  Future<void> deleteSupplier(String supplierId);
  // crear una escuela
  Future<void> createSchool(Schools school);
  //Actualizar una escuela
  Future<void> updateSchool(Schools school);
  //Eliminar una escuela
  Future<void> deleteSchool(String schoolId);
  // crear un tamaño
  Future<void> createSize(Sizes size);
  //Actualizar un tamaño
  Future<void> updateSize(Sizes size);
  //Eliminar un tamaño
  Future<void> deleteSize(String sizeId);
  //crear un sexo
  Future<void> createSex(Sex sex);
  //Actualizar un sexo
  Future<void> updateSex(Sex sex);
  //Eliminar un sexo
  Future<void> deleteSex(String sexId);
  //Obtener todos los productos
  Future<List<Products>> getProduct();
  //Obtener un producto por id
  Future<Products> getProductById({required int id});
  //Obtener todos los proveedores
  Future<List<Suppliers>> getSupplier();
  //Obtener todas las categorias
  Future<List<Categories>> getCategorie();
  //Obtener todos los tipos de prenda
  Future<List<TypeGarment>> getTypeGarment();
  //Obtener todas las escuelas
  Future<List<Schools>> getSchools();
  //Obtener todas las zonas
  Future<List<Zones>> getZone();
  //Obtener todos los sexos
  Future<List<Sex>> getSex();
  //Obtener todos los tamaños
  Future<List<Sizes>> getSize();
}

class SupabaseActionDataSourceImpl implements ActionDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<void> createProduct(Products product) async {
    try {
      await _supabase.from('products').upsert(product.toJson());
    } catch (e) {
      print('Error creating product: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(Products product) async {
    try {
      await _supabase.from('products').upsert(product.toJson());
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

  @override
  Future<void> updateCategory(Categories category) async {
    try {
      await _supabase.from('categories').upsert(category.toJson());
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
      await _supabase.from('type_garment').upsert(typeGarment.toJson());
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
      await _supabase.from('zones').upsert(zone.toJson());
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
      await _supabase.from('suppliers').upsert(supplier.toJson());
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
  Future<void> updateSchool(Schools school) async {
    try {
      await _supabase.from('schools').upsert(school.toJson());
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
      await _supabase.from('sizes').upsert(size.toJson());
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
      await _supabase.from('sex').upsert(sex.toJson());
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
}
