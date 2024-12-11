import 'package:tienda_comercial_chinito_app/features/home/data/datasources/supabase_product_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _productDataSource;
  ProductRepositoryImpl(this._productDataSource);

  @override
  Future<List<Products>> getProduct() async {
    return await _productDataSource.getProduct();
  }

  //getInventoryMovements
  @override
  Future<List<InventoryMovements>> getInventoryMovements() async {
    return await _productDataSource.getInventoryMovements();
  }

  @override
  Future<Products> getProductById({required int id}) async {
    return await _productDataSource.getProductById(id: id);
  }

  @override
  Future<List<Categories>> getCategorie() async {
    return await _productDataSource.getCategorie();
  }

  @override
  Future<List<TypeGarment>> getTypeGarment() async {
    return await _productDataSource.getTypeGarment();
  }

  @override
  Future<List<Schools>> getSchools() async {
    return await _productDataSource.getSchools();
  }

  @override
  Future<List<Sex>> getSex() async {
    return await _productDataSource.getSex();
  }

  @override
  Future<List<Sizes>> getSize() async {
    return await _productDataSource.getSize();
  }

  @override
  Future<void> createInventoryMovement(InventoryMovements movement) async {
    await _productDataSource.createInventoryMovement(movement);
  }

  @override
  Future<void> updateProductStock(String productId, int newStock) async {
    await _productDataSource.updateProductStock(productId, newStock);
  }
}
