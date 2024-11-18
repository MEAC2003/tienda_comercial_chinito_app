import 'package:tienda_comercial_chinito_app/features/auth/data/datasources/supabase_auth_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<AuthResult> signInWithEmail(
      {required String email, required String password}) {
    return _authDataSource.signInWithEmail(email: email, password: password);
  }

  @override
  Future<AuthResult> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _authDataSource.signUpWithEmail(
      fullName: fullName,
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResult> signInWithGoogle() {
    return _authDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }

  @override
  bool isSignedIn() {
    return _authDataSource.isSignedIn();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _authDataSource.resetPassword(email);
  }
}
