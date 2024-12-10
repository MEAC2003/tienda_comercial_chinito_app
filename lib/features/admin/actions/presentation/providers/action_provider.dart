import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/domain/repositories/action_repository.dart';

class ActionProvider extends ChangeNotifier {
  final ActionRepository _actionRepository;

  ActionProvider(this._actionRepository);

  List<Categories> _categories = [];
  List<TypeGarment> _typeGarments = [];
  List<Sex> _sexes = [];
  List<Sizes> _sizes = [];
  List<Schools> _schools = [];
  List<Suppliers> _suppliers = [];
  List<Zones> _zones = [];
  bool _isLoading = false;

  // Getters
  List<Categories> get categories => _categories;
  List<TypeGarment> get typeGarments => _typeGarments;
  List<Sex> get sexes => _sexes;
  List<Sizes> get sizes => _sizes;
  List<Zones> get zones => _zones;
  List<Schools> get schools => _schools;
  List<Suppliers> get suppliers => _suppliers;
  bool get isLoading => _isLoading;

  // Load all necessary data
  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _actionRepository.getCategorie();
      _typeGarments = await _actionRepository.getTypeGarment();
      _sexes = await _actionRepository.getSex();
      _sizes = await _actionRepository.getSize();
      _schools = await _actionRepository.getSchools();
      _suppliers = await _actionRepository.getSupplier();
      _zones = await _actionRepository.getZone();
    } catch (e) {
      print('Error loading initial data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Create new product
  Future<bool> createProduct({
    required String name,
    required List<String> imageUrls,
    required int salePrice,
    required int currentStock,
    required int minimumStock,
    required String typeGarmentId,
    required String supplierId,
    required String schoolId,
    required int sizeId,
    required int categoryId,
    required int sexId,
  }) async {
    try {
      final product = Products(
        // id and createdAt are handled by database
        name: name,
        imageUrl: imageUrls,
        salePrice: salePrice,
        currentStock: currentStock,
        minimumStock: minimumStock,
        typeGarmentId: typeGarmentId,
        supplierId: supplierId,
        schoolId: schoolId,
        sizeId: sizeId,
        categoryId: categoryId,
        sexId: sexId,
        isAvailable: true,
      );

      await _actionRepository.createProduct(product);
      return true;
    } catch (e) {
      print('Error creating product: $e');
      return false;
    }
  }

  Future<bool> createSchool({
    required String name,
    required String description,
    required String zoneId,
  }) async {
    try {
      final school = Schools(
        name: name,
        level: description,
        zoneId: zoneId,
      );
      await _actionRepository.createSchool(school);
      return true;
    } catch (e) {
      print('Error creating school: $e');
      return false;
    }
  }

  Future<bool> createCategory({required String name}) async {
    try {
      final category = Categories(
        name: name,
      );
      await _actionRepository.createCategory(category);
      return true;
    } catch (e) {
      print('Error creating category: $e');
      return false;
    }
  }

  Future<bool> createSize({required String name}) async {
    try {
      final size = Sizes(
        name: name,
      );
      await _actionRepository.createSize(size);
      return true;
    } catch (e) {
      print('Error creating size: $e');
      return false;
    }
  }

  Future<bool> createSupplier({
    required String dni,
    required String name,
    required String description,
    required String phone,
    required String bankAccount,
  }) async {
    try {
      final supplier = Suppliers(
        dni: dni,
        name: name,
        description: description,
        phone: phone,
        bankAccount: bankAccount,
      );
      await _actionRepository.createSupplier(supplier);
      return true;
    } catch (e) {
      print('Error creating supplier: $e');
      return false;
    }
  }
}
