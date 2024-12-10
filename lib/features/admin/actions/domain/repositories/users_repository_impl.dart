import 'package:tienda_comercial_chinito_app/features/admin/actions/data/datasources/supabase_users_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/domain/repositories/users_repository.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

class AdminUsersRepositoryImpl implements AdminUsersRepository {
  final AdminSupabaseUsersDataSource _dataSource;

  AdminUsersRepositoryImpl(this._dataSource);

  @override
  Future<PublicUser?> getCurrentUser() => _dataSource.getCurrentUser();

  @override
  Future<void> updateUser(PublicUser user) async {
    await _dataSource.updateUser(user);
  }

  @override
  Future<List<PublicUser>> getAllUsers() => _dataSource.getAllUsers();

  @override
  Future<void> updateUserRole(String userId, String newRole) async {
    await _dataSource.updateUserRole(userId, newRole);
  }
}
