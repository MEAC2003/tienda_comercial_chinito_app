import 'package:flutter/foundation.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/features/settings/domain/repositories/users_repository.dart';

class UserProvider extends ChangeNotifier {
  final UsersRepository _repository;
  AuthProvider _authProvider;
  PublicUser? _user;
  bool _isLoading = false;
  String? _error;

  UserProvider(this._repository, {required AuthProvider authProvider})
      : _authProvider = authProvider {
    print('UserProvider initialized');
    _authProvider.addListener(_onAuthStateChanged);
    _onAuthStateChanged();
  }

  PublicUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

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
