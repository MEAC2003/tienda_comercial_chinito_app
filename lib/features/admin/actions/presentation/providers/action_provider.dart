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
  List<Suppliers> _filteredSuppliers = [];
  String _supplierSearchQuery = '';
  List<Categories> _filteredCategories = [];
  String _categorySearchQuery = '';
  List<Zones> _filteredZones = [];
  String _zoneSearchQuery = '';
  List<Sizes> _filteredSizes = [];
  String _sizeSearchQuery = '';
  List<Schools> _filteredSchools = [];
  String _schoolSearchQuery = '';
  List<TypeGarment> _filteredTypeGarments = [];
  String _typeGarmentSearchQuery = '';

  List<TypeGarment> get filteredTypeGarments =>
      _typeGarmentSearchQuery.isEmpty ? _typeGarments : _filteredTypeGarments;
  List<Schools> get filteredSchools =>
      _schoolSearchQuery.isEmpty ? _schools : _filteredSchools;
  List<Categories> get filteredCategories =>
      _categorySearchQuery.isEmpty ? _categories : _filteredCategories;
  List<Suppliers> get filteredSuppliers =>
      _supplierSearchQuery.isEmpty ? _suppliers : _filteredSuppliers;
  List<Zones> get filteredZones =>
      _zoneSearchQuery.isEmpty ? _zones : _filteredZones;
  List<Sizes> get filteredSizes =>
      _sizeSearchQuery.isEmpty ? _sizes : _filteredSizes;
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
      _zones = await _actionRepository.getZone();
      _users = await _actionRepository.getUsers();
      _products = await _actionRepository.getProduct();
      _suppliers = await _actionRepository.getSupplier();
      _filteredSuppliers = _suppliers;
      _filteredCategories = _categories;
      _filteredZones = _zones;
      _filteredSizes = _sizes;
      _filteredSchools = _schools;
      _filteredTypeGarments = _typeGarments;
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

  void searchTypeGarments(String query) {
    _typeGarmentSearchQuery = query.toLowerCase();
    if (_typeGarmentSearchQuery.isEmpty) {
      _filteredTypeGarments = _typeGarments;
    } else {
      _filteredTypeGarments = _typeGarments.where((type) {
        return type.name.toLowerCase().contains(_typeGarmentSearchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void searchSuppliers(String query) {
    _supplierSearchQuery = query.toLowerCase();
    if (_supplierSearchQuery.isEmpty) {
      _filteredSuppliers = _suppliers;
    } else {
      _filteredSuppliers = _suppliers.where((supplier) {
        return supplier.name.toLowerCase().contains(_supplierSearchQuery) ||
            supplier.dni.toLowerCase().contains(_supplierSearchQuery) ||
            supplier.phone.toLowerCase().contains(_supplierSearchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void searchZones(String query) {
    _zoneSearchQuery = query.toLowerCase();
    if (_zoneSearchQuery.isEmpty) {
      _filteredZones = _zones;
    } else {
      _filteredZones = _zones.where((zone) {
        return zone.name.toLowerCase().contains(_zoneSearchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void searchCategories(String query) {
    _categorySearchQuery = query.toLowerCase();
    if (_categorySearchQuery.isEmpty) {
      _filteredCategories = _categories;
    } else {
      _filteredCategories = _categories.where((category) {
        return category.name.toLowerCase().contains(_categorySearchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void searchSchools(String query) {
    _schoolSearchQuery = query.toLowerCase();
    if (_schoolSearchQuery.isEmpty) {
      _filteredSchools = _schools;
    } else {
      _filteredSchools = _schools.where((school) {
        return school.name.toLowerCase().contains(_schoolSearchQuery) ||
            school.level.toLowerCase().contains(_schoolSearchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void searchSizes(String query) {
    _sizeSearchQuery = query.toLowerCase();
    if (_sizeSearchQuery.isEmpty) {
      _filteredSizes = _sizes;
    } else {
      _filteredSizes = _sizes.where((size) {
        return size.name.toLowerCase().contains(_sizeSearchQuery);
      }).toList();
    }
    notifyListeners();
  }

  Future<bool> createProduct({
    required String name,
    required List<String> imageUrls,
    required double salePrice,
    required int currentStock,
    required int minimumStock,
    required String typeGarmentId,
    required String supplierId,
    required String schoolId,
    required int sizeId,
    required int categoryId,
    required int sexId,
    required String userId,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Crear el producto
      final product = Products(
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

      // Guardar el producto y obtener su ID
      final String? productId = await _actionRepository.createProduct(product);

      if (productId == null) {
        throw Exception('Failed to get product ID after creation');
      }

      // Crear el movimiento de inventario con el ID obtenido
      final movement = InventoryMovements(
        createdAt: DateTime.now().toIso8601String(),
        productId: productId,
        movementTypeId: 1, // Ingreso
        quantity: currentStock,
        userId: userId,
      );

      await _actionRepository.createInventoryMovement(movement);

      // Actualizar el estado local con el ID
      product.id = productId;
      _products.add(product);
      _movements.add(movement);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error in createProduct: $e');
      _isLoading = false;
      notifyListeners();
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

  Future<Suppliers?> getSupplierById(String id) async {
    try {
      print('Searching for supplier with id: $id');

      // Ensure suppliers are loaded
      if (_suppliers.isEmpty) {
        print('Loading suppliers...');
        _suppliers = await _actionRepository.getSupplier();
      }

      print('Available suppliers: $_suppliers');

      final supplier = _suppliers.firstWhere(
        (supplier) => supplier.id == id,
        orElse: () => Suppliers(
          id: 'not-found',
          dni: 'N/A',
          name: 'Proveedor no encontrado',
          description: '',
          phone: 'N/A',
          bankAccount: 'N/A',
        ),
      );

      print('Found supplier: ${supplier.name}');
      return supplier;
    } catch (e) {
      print('Error getting supplier by id: $e');
      return null;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteProduct(productId);

      // Remove from local state
      _products.removeWhere((product) => product.id == productId);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct({
    required String id,
    required String name,
    required List<String> imageUrls,
    required double salePrice,
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
      _isLoading = true;
      notifyListeners();

      final product = Products(
        id: id,
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

      await _actionRepository.updateProduct(product);

      // Update local state
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = product;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating product: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> refreshProducts() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Get fresh data
      final products = await _actionRepository.getProduct();
      _products = products;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  // In ActionProvider class
  Future<bool> deleteSupplier(String supplierId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteSupplier(supplierId);

      // Remove from local state
      _suppliers.removeWhere((supplier) => supplier.id == supplierId);
      _filteredSuppliers = _suppliers; // Update filtered list too

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting supplier: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> updateSupplier({
    required String id,
    required String dni,
    required String name,
    required String description,
    required String phone,
    required String bankAccount,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final supplier = Suppliers(
        id: id,
        dni: dni,
        name: name,
        description: description,
        phone: phone,
        bankAccount: bankAccount,
      );

      await _actionRepository.updateSupplier(supplier);

      // Update local state
      final index = _suppliers.indexWhere((s) => s.id == id);
      if (index != -1) {
        _suppliers[index] = supplier;
        _filteredSuppliers = _suppliers; // Update filtered list too
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating supplier: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> deleteCategory(String categoryId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteCategory(categoryId);

      // Remove from local state
      _categories
          .removeWhere((category) => category.id.toString() == categoryId);
      _filteredCategories = _categories; // Update filtered list too

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting category: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> updateCategory({
    required String id,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final category = Categories(
        id: int.parse(id),
        name: name,
      );

      await _actionRepository.updateCategory(category);

      // Update local state
      final index = _categories.indexWhere((c) => c.id.toString() == id);
      if (index != -1) {
        _categories[index] = category;
        _filteredCategories = _categories; // Update filtered list too
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating category: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTypeGarment(String typeGarmentId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteTypeGarment(typeGarmentId);

      // Update local state
      _typeGarments.removeWhere((type) => type.id == typeGarmentId);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting type garment: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteZone(String zoneId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteZone(zoneId);

      // Update local state
      _zones.removeWhere((zone) => zone.id == zoneId);
      _filteredZones = _zones; // Update filtered list too

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting zone: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> updateZone({
    required String id,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final zone = Zones(
        id: id,
        name: name,
      );

      await _actionRepository.updateZone(zone);

      // Update local state
      final index = _zones.indexWhere((z) => z.id == id);
      if (index != -1) {
        _zones[index] = zone;
        _filteredZones = _zones; // Update filtered list too
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating zone: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> deleteSize(String sizeId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteSize(sizeId);

      // Update local state
      _sizes.removeWhere((size) => size.id.toString() == sizeId);
      _filteredSizes = _sizes; // Update filtered list too

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting size: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> updateSize({
    required String id,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final size = Sizes(
        id: int.parse(id), // Convert string ID to int for Sizes model
        name: name,
      );

      await _actionRepository.updateSize(size);

      // Update local state
      final index = _sizes.indexWhere((s) => s.id.toString() == id);
      if (index != -1) {
        _sizes[index] = size;
        _filteredSizes = _sizes; // Update filtered list too
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating size: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSchool(String schoolId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _actionRepository.deleteSchool(schoolId);

      // Update local state
      _schools.removeWhere((school) => school.id == schoolId);
      _filteredSchools = _schools; // Update filtered list too

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting school: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> updateSchool({
    required String id,
    required String name,
    required String level,
    required String zoneId,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final school = Schools(
        id: id,
        name: name,
        level: level,
        zoneId: zoneId,
      );

      await _actionRepository.updateSchool(school);

      // Update local state
      final index = _schools.indexWhere((s) => s.id == id);
      if (index != -1) {
        _schools[index] = school;
        _filteredSchools = _schools; // Update filtered list too
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating school: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // In ActionProvider class
  Future<bool> updateTypeGarment({
    required String id,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final typeGarment = TypeGarment(
        id: id,
        name: name,
      );

      await _actionRepository.updateTypeGarment(typeGarment);

      // Update local state
      final index = _typeGarments.indexWhere((type) => type.id == id);
      if (index != -1) {
        _typeGarments[index] = typeGarment;
        _filteredTypeGarments = _typeGarments; // Update filtered list too
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating type garment: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
