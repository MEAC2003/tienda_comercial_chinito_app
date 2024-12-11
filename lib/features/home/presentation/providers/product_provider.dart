import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/home/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/home/domain/repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _productRepository;
  List<Products> _products = [];
  List<Categories> _categories = [];
  List<TypeGarment> _typeGarment = [];
  List<Schools> _schools = [];
  List<Sex> _sex = [];
  List<Sizes> _sizes = [];
  List<Products> _filteredProducts = [];
  String _searchQuery = '';
  bool _isFiltering = false;
  bool _isLoading = false;
  bool _isSearching = false;
  int _resetKey = 0;
  int get resetKey => _resetKey;
  Map<String, int> _productQuantities = {};
  ProductProvider(this._productRepository) {
    loadProduct(); // Cargar los coches al inicializar el provider
  }
  List<Products> get availableProducts =>
      _products.where((product) => product.isAvailable).toList();
  List<Products> get products => _products;
  List<Categories> get categories => _categories;
  List<String> get sizesOptions {
    return _sizes.map((e) => e.name).toList()
      ..sort((a, b) {
        final isANumber = int.tryParse(a) != null;
        final isBNumber = int.tryParse(b) != null;

        if (isANumber && isBNumber) {
          return int.parse(a).compareTo(int.parse(b));
        } else if (isANumber) {
          return -1;
        } else if (isBNumber) {
          return 1;
        } else {
          return a.compareTo(b);
        }
      });
  }

  int getQuantity(String productId) {
    return _productQuantities[productId] ?? 1;
  }

  List<TypeGarment> get typeGarment => _typeGarment;
  List<Schools> get schools => _schools;
  List<Sex> get sex => _sex;
  List<Sizes> get sizes => _sizes;
  List<Products> get filteredProducts {
    if (!_isFiltering) {
      return _products;
    }
    return _filteredProducts;
  }

  bool get isLoading => _isLoading;
  bool get isFiltering => _isFiltering;
  bool get isSearching => _isSearching;

  List<String> get categoriesName => _categories.map((e) => e.name).toList();
  List<String> get typeGarmentName => _typeGarment.map((e) => e.name).toList();
  List<String> get schoolsName => _schools.map((e) => e.name).toList();
  List<String> get sexName => _sex.map((e) => e.name).toList();
  List<String> get sizesName => sizesOptions;

  Future<void> loadProduct() async {
    if (_products.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productRepository.getProduct();
      _categories = await _productRepository.getCategorie();
      _typeGarment = await _productRepository.getTypeGarment();
      _schools = await _productRepository.getSchools();
      _sex = await _productRepository.getSex();
      _sizes = await _productRepository.getSize();
      sizesOptions;
    } catch (e) {
      print('Error al cargar productos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetFilter() {
    _isFiltering = false;
    _filteredProducts = _products;
    _isSearching = false;
    _resetKey++; // Incrementa para forzar reconstrucción.
    notifyListeners();
  }

  Products? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  String getCategoryNameById(int id) {
    return _categories
        .firstWhere(
          (category) => category.id == id,
          orElse: () => Categories(id: -1, name: 'Unknown', createdAt: ''),
        )
        .name;
  }

  void filterByTypeGarment(String typeGarmentName) {
    if (typeGarmentName == 'Todo') {
      resetFilter();
    } else {
      _isFiltering = true;
      final typeGarment = _typeGarment.firstWhere(
          (type) => type.name == typeGarmentName,
          orElse: () => TypeGarment(id: '-1', name: 'Unknown', createdAt: ''));

      _filteredProducts = _products
          .where((product) =>
              product.typeGarmentId.trim() == typeGarment.id.trim())
          .toList();
    }
    notifyListeners();
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _isSearching = false;
      resetFilter();
      return;
    }

    _isSearching = true;
    _isFiltering = true;
    _filteredProducts = _products.where((product) {
      return product.name.toLowerCase().contains(_searchQuery) ||
          getSchoolNameById(product.schoolId)
              .toLowerCase()
              .contains(_searchQuery);
    }).toList();
    notifyListeners();
  }

  String getTypeGarmentNameById(String id) {
    return _typeGarment
        .firstWhere(
          (type) => type.id == id,
          orElse: () => TypeGarment(id: '-1', name: 'Unknown', createdAt: ''),
        )
        .name;
  }

  String getSchoolNameById(String id) {
    return _schools
        .firstWhere(
          (school) => school.id == id,
          orElse: () => Schools(
              id: '-1',
              name: 'Unknown',
              createdAt: '',
              level: 'Unknown',
              zoneId: '-1'),
        )
        .name;
  }

  String getSexNameById(int id) {
    return _sex
        .firstWhere(
          (sex) => sex.id == id,
          orElse: () => Sex(id: -1, name: 'Unknown', createdAt: ''),
        )
        .name;
  }

  String getSizeNameById(int id) {
    return _sizes
        .firstWhere(
          (size) => size.id == id,
          orElse: () => Sizes(id: -1, name: 'Unknown', createdAt: ''),
        )
        .name;
  }

  void filterByCategory(String categoryName) {
    if (categoryName == 'Todo') {
      resetFilter();
      return;
    }
    _isFiltering = true;
    final category = _categories.firstWhere(
      (category) => category.name == categoryName,
      orElse: () => Categories(id: -1, name: 'Unknown', createdAt: ''),
    );

    _filteredProducts = _products
        .where((product) => product.categoryId == category.id)
        .toList();

    notifyListeners();
  }

  void filterBySchool(String schoolName) {
    if (schoolName == 'Todo') {
      resetFilter();
      return;
    }
    _isFiltering = true;
    final school = _schools.firstWhere(
      (school) => school.name == schoolName,
      orElse: () => Schools(
          id: '-1', name: 'Unknown', createdAt: '', level: '', zoneId: '-1'),
    );

    _filteredProducts = _products
        .where((product) => product.schoolId.trim() == school.id.trim())
        .toList();

    notifyListeners();
  }

// Agrega métodos similares para otros filtros:
  void filterBySex(String sexName) {
    if (sexName == 'Todo') {
      resetFilter();
      return;
    }
    _isFiltering = true;
    final sex = _sex.firstWhere(
      (sex) => sex.name == sexName,
      orElse: () => Sex(id: -1, name: 'Unknown', createdAt: ''),
    );

    _filteredProducts =
        _products.where((product) => product.sexId == sex.id).toList();

    notifyListeners();
  }

// Filtro por tamaño (size)
  void filterBySize(String sizeName) {
    if (sizeName == 'Todo') {
      resetFilter();
      return;
    }
    _isFiltering = true;

    // Asegúrate de que las tallas estén ordenadas
    _sizes.sort((a, b) {
      final isANumber = int.tryParse(a.name) != null;
      final isBNumber = int.tryParse(b.name) != null;

      if (isANumber && isBNumber) {
        return int.parse(a.name).compareTo(int.parse(b.name));
      } else if (isANumber) {
        return -1;
      } else if (isBNumber) {
        return 1;
      } else {
        return a.name.compareTo(b.name);
      }
    });

    final size = _sizes.firstWhere(
      (s) => s.name == sizeName,
      orElse: () => Sizes(id: -1, name: 'Unknown', createdAt: ''),
    );

    _filteredProducts =
        _products.where((product) => product.sizeId == size.id).toList();

    notifyListeners();
  }

// Filtro por stock
  void filterByStock(String stockOption) {
    if (stockOption == 'Todo') {
      resetFilter();
      return;
    }
    _isFiltering = true;
    switch (stockOption.toLowerCase()) {
      case 'disponible':
        _filteredProducts =
            _products.where((product) => product.currentStock > 0).toList();
        break;
      case 'por agotarse':
        _filteredProducts = _products
            .where((product) =>
                product.currentStock <= product.minimumStock &&
                product.currentStock > 0)
            .toList();
        break;
      case 'agotado':
        _filteredProducts =
            _products.where((product) => product.currentStock <= 0).toList();
        break;
      default:
        // Si no se especifica una opción válida, muestra todos los productos
        _filteredProducts = _products;
    }

    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(String productId) {
    final product = getProductById(productId);
    if (product != null && getQuantity(productId) < product.currentStock) {
      _productQuantities[productId] = getQuantity(productId) + 1;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(String productId) {
    if (getQuantity(productId) > 1) {
      _productQuantities[productId] = getQuantity(productId) - 1;
      notifyListeners();
    }
  }

  // In ProductProvider class, update confirmOrder method:

  Future<bool> confirmOrder(String productId, String userId) async {
    final product = getProductById(productId);
    if (product == null) {
      print('Producto no encontrado');
      return false;
    }

    final quantity = getQuantity(productId);

    if (quantity > product.currentStock) {
      print('No hay suficiente stock para confirmar el pedido');
      return false;
    }

    try {
      // Disminuir el stock en la base de datos
      final newStock = product.currentStock - quantity;
      await _productRepository.updateProductStock(productId, newStock);

      // Actualizar el stock localmente
      product.currentStock = newStock;

      // Crear movimiento de inventario
      final movement = InventoryMovements(
        createdAt: DateTime.now().toIso8601String(),
        productId: productId,
        movementTypeId: 2, // ID para 'Egreso'
        quantity: quantity,
        userId: userId,
      );

      await _productRepository.createInventoryMovement(movement);

      // Reset quantity after successful order
      _productQuantities[productId] = 1;

      notifyListeners();
      return true;
    } catch (e) {
      print('Error al confirmar el pedido: $e');
      return false;
    }
  }

  void resetQuantityForProduct(String productId) {
    _productQuantities.remove(productId);
    notifyListeners();
  }

// Método para aplicar filtros múltiples
  void applyComplexFilter({
    String? typeGarment,
    String? school,
    String? sex,
    String? category,
    String? size,
    String? stockStatus,
  }) {
    _isFiltering = true;
    _sizes.sort((a, b) {
      final isANumber = int.tryParse(a.name) != null;
      final isBNumber = int.tryParse(b.name) != null;

      if (isANumber && isBNumber) {
        return int.parse(a.name).compareTo(int.parse(b.name));
      } else if (isANumber) {
        return -1;
      } else if (isBNumber) {
        return 1;
      } else {
        return a.name.compareTo(b.name);
      }
    });
    _filteredProducts = _products.where((product) {
      bool matches = true;

      // Filtro por tipo de prenda
      if (typeGarment != null && typeGarment != 'Todo') {
        final typeGarmentObj = _typeGarment.firstWhere(
          (type) => type.name == typeGarment,
          orElse: () => TypeGarment(id: '-1', name: 'Unknown', createdAt: ''),
        );
        matches &= product.typeGarmentId.trim() == typeGarmentObj.id.trim();
      }

      // Filtro por escuela
      if (school != null && typeGarment != 'Todo') {
        final schoolObj = _schools.firstWhere(
          (s) => s.name == school,
          orElse: () => Schools(
              id: '-1',
              name: 'Unknown',
              createdAt: '',
              level: '',
              zoneId: '-1'),
        );
        matches &= product.schoolId.trim() == schoolObj.id.trim();
      }

      // Filtro por sexo
      if (sex != null && typeGarment != 'Todo') {
        final sexObj = _sex.firstWhere(
          (s) => s.name == sex,
          orElse: () => Sex(id: -1, name: 'Unknown', createdAt: ''),
        );
        matches &= product.sexId == sexObj.id;
      }

      // Filtro por nivel
      if (category != null && typeGarment != 'Todo') {
        final categoryObj = _categories.firstWhere(
          (c) => c.name == category,
          orElse: () => Categories(id: -1, name: 'Unknown', createdAt: ''),
        );
        matches &= product.categoryId == categoryObj.id;
      }

      // Filtro por talla
      if (size != null && size != 'Todo') {
        final sizeObj = _sizes.firstWhere(
          (s) => s.name == size,
          orElse: () => Sizes(id: -1, name: 'Unknown', createdAt: ''),
        );
        matches &= product.sizeId == sizeObj.id;
      }

      // Filtro por stock
      if (stockStatus != null && typeGarment != 'Todo') {
        switch (stockStatus.toLowerCase()) {
          case 'disponible':
            matches &= product.currentStock > 0;
            break;
          case 'por agotarse':
            matches &= product.currentStock <= product.minimumStock &&
                product.currentStock > 0;
            break;
          case 'agotado':
            matches &= product.currentStock <= 0;
            break;
        }
      }
      return matches;
    }).toList();

    notifyListeners();
  }

// Método para obtener las opciones de stock
  List<String> getStockOptions() {
    return ['Disponible', 'Por agotarse', 'Agotado'];
  }
}
