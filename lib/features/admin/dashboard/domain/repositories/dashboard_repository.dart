import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/zones.dart';

abstract class DashboardRepository {
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
