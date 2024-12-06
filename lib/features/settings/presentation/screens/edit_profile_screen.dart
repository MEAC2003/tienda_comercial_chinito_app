import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Editar Perfil',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  late TextEditingController _fullNameController;
  late final String _email;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user!;
    _fullNameController = TextEditingController(text: user.fullName);
    _email = user.email;
    _phoneController = TextEditingController(text: user.phone);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final PublicUser? user = userProvider.user;

    // Handle loading and error states
    if (userProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (userProvider.error != null) {
      return Center(child: Text('Error: ${userProvider.error}'));
    }

    // If user is null, show a message
    if (user == null) {
      return Center(child: Text('No user data available'));
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: AppSize.defaultPadding * 2),
          Center(
            child: CircleAvatar(
              radius: 65,
              backgroundImage: user.avatarUrl.isNotEmpty
                  ? NetworkImage(user.avatarUrl)
                  : null,
              child: user.avatarUrl.isEmpty
                  ? const Icon(Icons.person, size: 65)
                  : null,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding * 2),
          CustomTextField(
            controller: _fullNameController,
            hintText: 'Nombre completo',
            icon: const Icon(Icons.person),
            obscureText: false,
          ),
          SizedBox(height: AppSize.defaultPadding * 0.7),
          CustomTextField(
            hintText: _email,
            icon: const Icon(Icons.email),
            readOnly: true,
          ),
          SizedBox(height: AppSize.defaultPadding * 0.7),
          CustomTextField(
            controller: _phoneController,
            hintText: 'Número de teléfono',
            icon: const Icon(Icons.phone),
          ),
          SizedBox(height: AppSize.defaultPadding * 2.5),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.defaultPaddingHorizontal * 1.5),
            child: CustomActionButton(
              text: 'Guardar Cambios',
              color: AppColors.primaryColor,
              onPressed: () {
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                final updatedUser = userProvider.user!.copyWith(
                  fullName: _fullNameController.text,
                  phone: _phoneController.text,
                );
                userProvider.updateUser(updatedUser);
              },
            ),
          ),
        ],
      ),
    );
  }
}
