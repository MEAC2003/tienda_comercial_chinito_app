import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';

abstract class UsersRepository {
  Future<PublicUser?> getCurrentUser();
  Future<void> updateUser(PublicUser user);
}
