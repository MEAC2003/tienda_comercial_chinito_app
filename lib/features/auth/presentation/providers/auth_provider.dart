import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/enums/user_role.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;
  String? _userRole;

  bool get isAuthenticated => _currentUser != null;

  bool hasRole(String role) {
    return _userRole == role;
  }

  AuthProvider(this._authRepository) {
    _initializeSession();
  }

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> _initializeSession() async {
    _currentUser = Supabase.instance.client.auth.currentUser;
    if (_currentUser != null) {
      await fetchUserRole();
    }
    notifyListeners();

    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      _currentUser = data.session?.user;
      if (_currentUser != null) {
        await fetchUserRole();
      } else {
        _userRole = null;
      }
      notifyListeners();
    });
  }

  UserRole get userRole => UserRole.values.firstWhere(
      (role) => role.toString().split('.').last == _userRole,
      orElse: () => UserRole.user);

  void _handleAuthResult(AuthResult result) {
    if (result.success) {
      _currentUser = Supabase.instance.client.auth.currentUser;
      _errorMessage = null;
    } else {
      _errorMessage = result.error ?? 'Error de autenticación';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthResult> signInWithEmail(String email, String password) async {
    return _performAuthAction(() => _authRepository.signInWithEmail(
          email: email,
          password: password,
        ));
  }

  Future<AuthResult> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return _performAuthAction(() => _authRepository.signUpWithEmail(
          fullName: fullName,
          email: email,
          password: password,
        ));
  }

  Future<AuthResult> signInWithGoogle() async {
    return _performAuthAction(() => _authRepository.signInWithGoogle());
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _currentUser = null;
    _userRole = null;
    notifyListeners();
  }

  Future<AuthResult> _performAuthAction(
      Future<AuthResult> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await action();
      if (result.success) {
        _currentUser = Supabase.instance.client.auth.currentUser;
        await fetchUserRole();
      } else {
        _errorMessage = result.error ?? "Authentication failed";
      }
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return AuthResult(success: false, isNewUser: false, error: _errorMessage);
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is AuthException) {
      switch (error.message) {
        case 'Invalid login credentials':
          return 'Email o contraseña incorrectos';
        case 'Email not confirmed':
          return 'Por favor, confirme su email antes de iniciar sesión';
        default:
          return 'Error de autenticación: ${error.message}';
      }
    }
    return 'Ocurrió un error inesperado';
  }

  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authRepository.resetPassword(email);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage =
          'No se pudo enviar el email de recuperación: ${_getErrorMessage(e)}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchUserRole() async {
    if (_currentUser == null) return;

    try {
      final response = await Supabase.instance.client
          .from('public_users')
          .select('role')
          .eq('id', _currentUser!.id)
          .single();
      _userRole = response['role'] as String?;
      notifyListeners();
    } catch (e) {
      print('Error fetching user role: $e');
      _userRole = 'user';
    }
    print('Fetched user role: $_userRole');
  }

  Future<void> checkAuthStatus() async {
    _currentUser = Supabase.instance.client.auth.currentUser;
    if (_currentUser != null) {
      await fetchUserRole();
    }
    notifyListeners();
  }

  Future<void> initializeUser() async {
    _currentUser = Supabase.instance.client.auth.currentUser;
    if (_currentUser != null) {
      await fetchUserRole();
    }
    notifyListeners();
  }
}
