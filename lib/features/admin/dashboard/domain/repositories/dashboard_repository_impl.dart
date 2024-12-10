import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/datasources/supabase_dashboard_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource _dashboardDataSource;
  DashboardRepositoryImpl(this._dashboardDataSource);

  @override
  Future<List<Products>> getProduct() async {
    return await _dashboardDataSource.getProduct();
  }

  @override
  Future<Products> getProductById({required int id}) async {
    return await _dashboardDataSource.getProductById(id: id);
  }

  @override
  Future<List<Categories>> getCategorie() async {
    return await _dashboardDataSource.getCategorie();
  }

  @override
  Future<List<TypeGarment>> getTypeGarment() async {
    return await _dashboardDataSource.getTypeGarment();
  }

  @override
  Future<List<Schools>> getSchools() async {
    return await _dashboardDataSource.getSchools();
  }

  // Future<List<Sex>> getSex();
  // Future<List<Sizes>> getSize();
  // Future<List<Suppliers>> getSuppliers();
  // Future<List<Zones>> getZones();
  // Future<List<InventoryMovements>> getInventoryMovements();
  @override
  Future<List<Sex>> getSex() async {
    return await _dashboardDataSource.getSex();
  }

  @override
  Future<List<Sizes>> getSize() async {
    return await _dashboardDataSource.getSize();
  }

  @override
  Future<List<Suppliers>> getSuppliers() async {
    return await _dashboardDataSource.getSuppliers();
  }

  @override
  Future<List<Zones>> getZones() async {
    return await _dashboardDataSource.getZones();
  }

  @override
  Future<List<InventoryMovements>> getInventoryMovements() async {
    return await _dashboardDataSource.getInventoryMovements();
  }
}
