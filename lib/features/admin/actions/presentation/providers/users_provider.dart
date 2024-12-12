import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/domain/repositories/users_repository.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

class AdminUserProvider extends ChangeNotifier {
  final AdminUsersRepository _repository;
  AuthProvider _authProvider;
  PublicUser? _user;
  bool _isLoading = false;
  String? _error;
  List<PublicUser> _users = [];

  AdminUserProvider(this._repository, {required AuthProvider authProvider})
      : _authProvider = authProvider {
    print('UserProvider initialized');
    _authProvider.addListener(_onAuthStateChanged);
    _onAuthStateChanged();
  }

  PublicUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<PublicUser> get users => _users;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _repository.getAllUsers();
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  // Nuevo método para actualizar el rol de un usuario
  Future<void> updateUserRole(String userId, String newRole) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.updateUserRole(userId, newRole);

      // Actualizar el rol del usuario en la lista local si es el usuario actual
      if (_user != null && _user!.id == userId) {
        _user = _user!.copyWith(role: newRole);
      }

      // Recargar la lista de usuarios
      await fetchUsers();

      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  void updateAuthProvider(AuthProvider authProvider) {
    print('Updating AuthProvider');
    if (_authProvider != authProvider) {
      print('New AuthProvider provided, updating listeners');
      _authProvider.removeListener(_onAuthStateChanged);
      _authProvider = authProvider;
      _authProvider.addListener(_onAuthStateChanged);
      _onAuthStateChanged();
    } else {
      print('AuthProvider unchanged');
    }
  }

  void _onAuthStateChanged() {
    print(
        'Auth state changed. isAuthenticated: ${_authProvider.isAuthenticated}');
    if (_authProvider.isAuthenticated) {
      print('User is authenticated, getting current user');
      getCurrentUser();
    } else {
      print('User is not authenticated, clearing user data');
      clearUser();
    }
  }

  Future<void> getCurrentUser() async {
    print('getCurrentUser called');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print('Fetching current user from repository');
      _user = await _repository.getCurrentUser();
      print('User fetched: ${_user?.toJson()}');
    } catch (e) {
      print('Error fetching user: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  Future<void> updateUser(PublicUser user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.updateUser(user);
      _user = user;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authProvider.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
