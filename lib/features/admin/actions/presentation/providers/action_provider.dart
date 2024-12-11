import 'package:flutter/material.dart';
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

class ActionProvider extends ChangeNotifier {
  final ActionRepository _actionRepository;

  ActionProvider(this._actionRepository);
  //  getUsers
  List<PublicUser> _users = [];
  List<Categories> _categories = [];
  List<TypeGarment> _typeGarments = [];
  List<Sex> _sexes = [];
  List<Sizes> _sizes = [];
  List<Schools> _schools = [];
  List<Suppliers> _suppliers = [];
  List<Zones> _zones = [];
  List<Products> _products = [];
  bool _isLoading = false;
  bool _isFiltering = false;
  String _searchQuery = '';
  int _resetKey = 0;
  int get resetKey => _resetKey;
  List<InventoryMovements> _movements = [];
  List<InventoryMovements> _filteredMovements = [];
  String? _error;
  // Getters
  List<Categories> get categories => _categories;
  List<TypeGarment> get typeGarments => _typeGarments;
  List<Sex> get sexes => _sexes;
  List<Sizes> get sizes => _sizes;
  List<Zones> get zones => _zones;
  List<Schools> get schools => _schools;
  List<Suppliers> get suppliers => _suppliers;
  List<PublicUser> get users => _users;
  List<Products> get products => _products;
  bool get isLoading => _isLoading;
  bool get isFiltering => _isFiltering;
  List<InventoryMovements> get movements =>
      _searchQuery.isEmpty && !_isFiltering ? _movements : _filteredMovements;
  bool get hasError => _error != null;
  String? get error => _error;
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
      _users = await _actionRepository.getUsers();
      _products = await _actionRepository.getProduct();
    } catch (e) {
      print('Error loading initial data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMovements() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _users = await _actionRepository.getUsers();
      _movements = await _actionRepository.getInventoryMovements();
      _filteredMovements = _movements;
    } catch (e) {
      _error = 'Error al cargar los movimientos: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //obtener un usuario por id

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

  Future<bool> createTypeGarment({required String name}) async {
    try {
      final typeGarment = TypeGarment(
        name: name,
      );
      await _actionRepository.createTypeGarment(typeGarment);
      return true;
    } catch (e) {
      print('Error creating type garment: $e');
      return false;
    }
  }

  Future<bool> createZone({required String name}) async {
    try {
      final zone = Zones(
        name: name,
      );
      await _actionRepository.createZone(zone);
      return true;
    } catch (e) {
      print('Error creating zone: $e');
      return false;
    }
  }

  void searchMovements(String query) {
    _searchQuery = query;
    _filterMovements();
  }

  // Filter by date range
  void filterByDateRange(DateTime startDate, DateTime endDate) {
    _isFiltering = true;
    _filteredMovements = _movements.where((movement) {
      final movementDate = DateTime.parse(movement.createdAt);
      return movementDate.isAfter(startDate) &&
          movementDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
    notifyListeners();
  }

  Future<Products?> getProductById(String id) async {
    try {
      return await _actionRepository.getProductById(id: id);
    } catch (e) {
      print('Error getting product by id: $e');
      return null;
    }
  }

  // Filter by movement type
  void filterByType(int typeId) {
    _isFiltering = true;
    _filteredMovements = _movements.where((movement) {
      return movement.movementTypeId == typeId;
    }).toList();
    notifyListeners();
  }

  // Combined filter and search
  void _filterMovements() {
    _filteredMovements = _movements.where((movement) {
      final matchesSearch = _searchQuery.isEmpty ||
          movement.productId.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesSearch;
    }).toList();
    notifyListeners();
  }

  // Reset all filters
  void resetFilters() {
    _isFiltering = false;
    _searchQuery = '';
    _filteredMovements = _movements;
    _resetKey++;
    notifyListeners();
  }

  // Format date for display
  String formatDate(String date) {
    final dateTime = DateTime.parse(date);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  InventoryMovements? getMovementById(String id) {
    try {
      return _movements.firstWhere(
        (movement) => movement.id == id,
      );
    } catch (e) {
      return null;
    }
  }

  PublicUser? getUserById(String id) {
    try {
      print('id: $id');
      print('Users: $_users');
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      print('Error getting user by id: $e');
      return null;
    }
  }
}
