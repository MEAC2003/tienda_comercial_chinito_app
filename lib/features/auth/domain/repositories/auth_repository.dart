import 'package:tienda_comercial_chinito_app/features/auth/data/datasources/supabase_auth_data_source.dart';

abstract class AuthRepository {
  Future<AuthResult> signInWithEmail(
      {required String email, required String password});
  Future<AuthResult> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  });
  Future<AuthResult> signInWithGoogle();
  Future<void> resetPassword(String email);
  Future<void> signOut();
  bool isSignedIn();
}
