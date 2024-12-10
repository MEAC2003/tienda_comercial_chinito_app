import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _dashboardRepository;

  DashboardProvider(this._dashboardRepository);

  bool isLoading = false;
  String? error;
  List<InventoryMovements> _inventoryMovements = [];
  List<Products> _products = [];

  int totalProducts = 0;
  int lowStockProducts = 0;
  int mediumStockProducts = 0;

  Future<void> loadInventoryMovements() async {
    try {
      isLoading = true;
      notifyListeners();

      _inventoryMovements = await _dashboardRepository.getInventoryMovements();
      _products = await _dashboardRepository
          .getProduct(); // We need products for prices

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  List<double> getMonthlyExpenses() {
    if (_inventoryMovements.isEmpty) return List.filled(6, 0.0);

    Map<int, double> monthlyTotals = {};

    for (var movement in _inventoryMovements) {
      final date = DateTime.parse(movement.createdAt);
      final month = date.month;

      // Assuming movementTypeId 2 represents expenses/outgoing stock
      if (movement.movementTypeId == 2) {
        // Find product price
        final product = _products.firstWhere(
          (p) => p.id == movement.productId,
          orElse: () => Products(
              id: "",
              createdAt: "",
              name: "",
              imageUrl: [],
              salePrice: 0,
              currentStock: 0,
              minimumStock: 0,
              typeGarmentId: "",
              supplierId: "",
              schoolId: "",
              sizeId: 0,
              categoryId: 0,
              sexId: 0,
              isAvailable: false),
        );

        final amount = movement.quantity.abs() * product.salePrice;
        monthlyTotals[month] = (monthlyTotals[month] ?? 0) + amount;
      }
    }

    // Return last 6 months of data
    List<double> expenses = [];
    final now = DateTime.now();
    for (int i = 6; i > 0; i--) {
      final month = now.month - i + 1;
      expenses.add(monthlyTotals[month] ?? 0.0);
    }

    return expenses;
  }

  Future<void> loadProductStats() async {
    try {
      isLoading = true;
      notifyListeners();

      final products = await _dashboardRepository.getProduct();

      totalProducts = products.where((p) => p.isAvailable).length;

      lowStockProducts = products
          .where((p) => p.isAvailable && p.currentStock <= p.minimumStock)
          .length;

      mediumStockProducts = products
          .where((p) =>
              p.isAvailable &&
              p.currentStock > p.minimumStock &&
              p.currentStock <= (p.minimumStock * 2))
          .length;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
