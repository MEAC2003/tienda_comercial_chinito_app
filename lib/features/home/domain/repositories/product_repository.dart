import 'package:tienda_comercial_chinito_app/features/home/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/type_garment.dart';

abstract class ProductRepository {
  Future<List<Products>> getProduct();
  Future<Products> getProductById({required int id});
  Future<List<Categories>> getCategorie();
  Future<List<TypeGarment>> getTypeGarment();
  Future<List<Schools>> getSchools();
  Future<List<Sex>> getSex();
  Future<List<Sizes>> getSize();
  Future<void> createInventoryMovement(InventoryMovements movement);
  Future<void> updateProductStock(String productId, int newStock);
  //get getInventoryMovements
  Future<List<InventoryMovements>> getInventoryMovements();
}
