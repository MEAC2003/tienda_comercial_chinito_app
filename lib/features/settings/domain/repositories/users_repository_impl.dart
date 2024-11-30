import 'package:tienda_comercial_chinito_app/features/settings/data/datasources/supabase_users_data_source.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/features/settings/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final SupabaseUsersDataSource _dataSource;

  UsersRepositoryImpl(this._dataSource);

  @override
  Future<PublicUser?> getCurrentUser() => _dataSource.getCurrentUser();

  @override
  Future<void> updateUser(PublicUser user) async {
    await _dataSource.updateUser(user);
  }
}
