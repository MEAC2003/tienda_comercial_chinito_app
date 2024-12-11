import 'package:tienda_comercial_chinito_app/features/admin/actions/data/datasources/supabase_action_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/domain/repositories/action_repository.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

class ActionRepositoryImpl implements ActionRepository {
  final ActionDataSource _dataSource;
  ActionRepositoryImpl(this._dataSource);

  @override
  Future<void> createCategory(Categories category) {
    return _dataSource.createCategory(category);
  }

  @override
  Future<void> createSchool(Schools school) {
    return _dataSource.createSchool(school);
  }

  @override
  Future<void> createSex(Sex sex) {
    return _dataSource.createSex(sex);
  }

  @override
  Future<void> createSize(Sizes size) {
    return _dataSource.createSize(size);
  }

  @override
  Future<void> createSupplier(Suppliers supplier) {
    return _dataSource.createSupplier(supplier);
  }

  @override
  Future<void> createTypeGarment(TypeGarment typeGarment) {
    return _dataSource.createTypeGarment(typeGarment);
  }

  @override
  Future<void> createZone(Zones zone) {
    return _dataSource.createZone(zone);
  }

  @override
  Future<void> deleteCategory(String categoryId) {
    return _dataSource.deleteCategory(categoryId);
  }

  @override
  Future<void> deleteSchool(String schoolId) {
    return _dataSource.deleteSchool(schoolId);
  }

  @override
  Future<void> deleteSex(String sexId) {
    return _dataSource.deleteSex(sexId);
  }

  @override
  Future<void> deleteSize(String sizeId) {
    return _dataSource.deleteSize(sizeId);
  }

  @override
  Future<void> deleteSupplier(String supplierId) {
    return _dataSource.deleteSupplier(supplierId);
  }

  @override
  Future<void> deleteTypeGarment(String typeGarmentId) {
    return _dataSource.deleteTypeGarment(typeGarmentId);
  }

  @override
  Future<void> deleteZone(String zoneId) {
    return _dataSource.deleteZone(zoneId);
  }

  @override
  Future<List<Categories>> getCategorie() {
    return _dataSource.getCategorie();
  }

  @override
  Future<List<Schools>> getSchools() {
    return _dataSource.getSchools();
  }

  @override
  Future<List<Sex>> getSex() {
    return _dataSource.getSex();
  }

  @override
  Future<List<Sizes>> getSize() {
    return _dataSource.getSize();
  }

  @override
  Future<List<Suppliers>> getSupplier() {
    return _dataSource.getSupplier();
  }

  @override
  Future<List<TypeGarment>> getTypeGarment() {
    return _dataSource.getTypeGarment();
  }

  @override
  Future<List<Zones>> getZone() {
    return _dataSource.getZone();
  }

  @override
  Future<List<Products>> getProduct() {
    return _dataSource.getProduct();
  }

  @override
  Future<Products> getProductById({required String id}) {
    return _dataSource.getProductById(id: id);
  }

  @override
  Future<List<PublicUser>> getUsers() {
    return _dataSource.getUsers();
  }

  @override
  Future<PublicUser> getUserById({required String id}) {
    return _dataSource.getUserById(id: id);
  }

  @override
  Future<Suppliers> getSupplierById({required String id}) {
    return _dataSource.getSupplierById(id: id);
  }

  @override
  Future<List<InventoryMovements>> getInventoryMovements() {
    return _dataSource.getInventoryMovements();
  }

  @override
  Future<void> updateCategory(Categories category) {
    return _dataSource.updateCategory(category);
  }

  @override
  Future<void> updateSchool(Schools school) {
    return _dataSource.updateSchool(school);
  }

  @override
  Future<void> updateSex(Sex sex) {
    return _dataSource.updateSex(sex);
  }

  @override
  Future<void> updateSize(Sizes size) {
    return _dataSource.updateSize(size);
  }

  @override
  Future<void> updateSupplier(Suppliers supplier) {
    return _dataSource.updateSupplier(supplier);
  }

  @override
  Future<void> updateTypeGarment(TypeGarment typeGarment) {
    return _dataSource.updateTypeGarment(typeGarment);
  }

  @override
  Future<void> updateZone(Zones zone) {
    return _dataSource.updateZone(zone);
  }

  @override
  Future<void> createProduct(Products product) {
    return _dataSource.createProduct(product);
  }

  @override
  Future<void> deleteProduct(String productId) {
    return _dataSource.deleteProduct(productId);
  }

  @override
  Future<void> updateProduct(Products product) {
    return _dataSource.updateProduct(product);
  }
}
