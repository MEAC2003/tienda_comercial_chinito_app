import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          'Ajustes',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5),
        child: Column(
          children: [
            SizedBox(height: AppSize.defaultPadding * 1.5),
            const SwitchNotifications(),
            SizedBox(height: AppSize.defaultPadding),
            CustomListTile(
              leadingIcon: const Icon(Icons.border_color),
              title: 'Editar Perfil',
              trailingIcon: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.push(AppRouter.editProfile);
              },
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomListTile(
              leadingIcon: const Icon(Icons.offline_share),
              title: 'Cerrar Sesión',
              trailingIcon: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
                GoRouter.of(context).go(AppRouter.signIn);
              },
            ),
          ],
        ),
      ),
    );
  }
}
