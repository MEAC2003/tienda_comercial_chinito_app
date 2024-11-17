import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthResult {
  final bool success;
  final bool isNewUser;
  final String? error;

  AuthResult({required this.success, required this.isNewUser, this.error});
}

abstract class AuthDataSource {
  Future<AuthResult> signInWithEmail(
      {required String email, required String password});
  Future<AuthResult> signUpWithEmail(
      {required String fullName,
      required String email,
      required String password});
  Future<AuthResult> signInWithGoogle();
  Future<void> resetPassword(String email);
  Future<void> signOut();
  bool isSignedIn();
}

class SupabaseAuthDataSourceImpl implements AuthDataSource {
  final _supabase = Supabase.instance.client;
  final _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_CLIENT_ID']!,
    serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID']!,
  );

  @override
  Future<AuthResult> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final response = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      return AuthResult(success: response.session != null, isNewUser: false);
    } catch (e) {
      return AuthResult(success: false, isNewUser: false, error: e.toString());
    }
  }

  @override
  Future<AuthResult> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user != null) {
        // Actualizar el perfil del usuario con el nombre completo
        await _supabase.from('profiles').upsert({
          'id': response.user!.id,
          'full_name': fullName,
          'updated_at': DateTime.now().toIso8601String(),
        });
      }

      return AuthResult(success: response.user != null, isNewUser: true);
    } catch (e) {
      if (e.toString().contains('429')) {
        return AuthResult(
            success: false,
            isNewUser: false,
            error:
                "Has excedido el límite de intentos. Por favor, espera unos minutos antes de intentar de nuevo.");
      }
      return AuthResult(success: false, isNewUser: false, error: e.toString());
    }
  }

  @override
  Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return AuthResult(
          success: false,
          isNewUser: false,
          error: 'Google sign in was cancelled',
        );
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthResponse res = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      final isNewUser = res.session?.user.appMetadata['provider'] == 'google' &&
          res.session?.user.appMetadata['providers']?.length == 1;

      return AuthResult(success: res.session != null, isNewUser: isNewUser);
    } catch (e) {
      return AuthResult(success: false, isNewUser: false, error: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabase.auth.signOut();
  }

  @override
  bool isSignedIn() => _supabase.auth.currentUser != null;

  @override
  Future<void> resetPassword(String email) async {
    await Supabase.instance.client.auth.resetPasswordForEmail(email);
  }
}
