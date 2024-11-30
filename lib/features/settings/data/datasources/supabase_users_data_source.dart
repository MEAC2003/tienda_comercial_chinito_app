import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

class SupabaseUsersDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseUsersDataSource(this._supabaseClient);

  Future<PublicUser?> getCurrentUser() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await _supabaseClient
        .from('public_users')
        .select()
        .eq('id', userId)
        .single();

    return PublicUser.fromJson(response);
  }

  Future<void> updateUser(PublicUser user) async {
    await _supabaseClient
        .from('public_users')
        .update(user.toJson())
        .eq('id', user.id);
  }
}
