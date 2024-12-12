import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/users_provider.dart';

import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart'; // Ajusta esta importación según tu estructura

class AdminRolesScreen extends StatefulWidget {
  const AdminRolesScreen({super.key});

  @override
  State<AdminRolesScreen> createState() => _AdminRolesScreenState();
}

class _AdminRolesScreenState extends State<AdminRolesScreen> {
  final List<String> _availableRoles = ['pending', 'user', 'admin'];

  @override
  void initState() {
    super.initState();
    // Cargar usuarios al iniciar la pantalla
    Future.microtask(() => context.read<AdminUserProvider>().fetchUsers());
  }

  void _showRoleChangeDialog(PublicUser user) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedRole = user.role;
        return AlertDialog(
          //Nombre en mayuscula y minuscula
          title: Text(
              'Cambiar rol de ${user.fullName.split(' ').map((name) => name[0].toUpperCase() + name.substring(1).toLowerCase()).join(' ')}',
              style: AppStyles.h2(color: AppColors.darkColor)),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: _availableRoles.map((role) {
                  return RadioListTile<String>(
                    title: Text(
                      _getRoleLabel(role),
                      style: AppStyles.h4(),
                    ),
                    value: role,
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text('Cancelar', style: AppStyles.h4()),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRole != null) {
                  try {
                    await context.read<AdminUserProvider>().updateUserRole(
                          user.id,
                          selectedRole!,
                        );
                    if (!context.mounted) return;
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rol actualizado exitosamente'),
                        backgroundColor: AppColors.primarySkyBlue,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Error al actualizar rol: ${e.toString()}'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySkyBlue,
              ),
              child: Text('Guardar', style: AppStyles.h4(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'pending':
        return 'Pendiente';
      case 'user':
        return 'Usuario';
      case 'admin':
        return 'Administrador';
      default:
        return role;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'pending':
        return Colors.orange;
      case 'user':
        return Colors.blue;
      case 'admin':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<AdminUserProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Gestión de Roles',
          style: AppStyles.h2(color: AppColors.darkColor),
        ),
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProvider.error != null
              ? Center(child: Text('Error: ${userProvider.error}'))
              : ListView.separated(
                  padding: EdgeInsets.all(AppSize.defaultPadding),
                  itemCount: userProvider.users.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  itemBuilder: (context, index) {
                    final user = userProvider.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: user.avatarUrl.isNotEmpty
                            ? NetworkImage(user.avatarUrl)
                            : null,
                        child: user.avatarUrl.isEmpty
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(
                        user.fullName
                            .split(' ')
                            .map((name) =>
                                name[0].toUpperCase() +
                                name.substring(1).toLowerCase())
                            .take(2)
                            .join(' '),
                        style: AppStyles.h3(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        user.email,
                        style: AppStyles.h4(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getRoleColor(user.role).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          _getRoleLabel(user.role),
                          style: AppStyles.h4(
                            color: _getRoleColor(user.role),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () => _showRoleChangeDialog(user),
                    );
                  },
                ),
    );
  }
}
