import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

abstract class AdminUsersRepository {
  Future<PublicUser?> getCurrentUser();
  Future<void> updateUser(PublicUser user);
  Future<List<PublicUser>> getAllUsers();
  Future<void> updateUserRole(String userId, String newRole);
}
