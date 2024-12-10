import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';

abstract class ActionRepository {
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
