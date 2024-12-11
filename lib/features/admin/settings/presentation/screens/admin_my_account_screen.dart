import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminMyAccountScreen extends StatelessWidget {
  const AdminMyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AdminMyAccountView(),
    );
  }
}

class _AdminMyAccountView extends StatefulWidget {
  const _AdminMyAccountView();

  @override
  State<_AdminMyAccountView> createState() => _AdminMyAccountViewState();
}

class _AdminMyAccountViewState extends State<_AdminMyAccountView> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final PublicUser? user = userProvider.user;
    String? _selectedSection;
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultPadding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: user.avatarUrl.isNotEmpty
                        ? NetworkImage(user.avatarUrl)
                        : null,
                    child: user.avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 35)
                        : null,
                  ),
                  SizedBox(width: AppSize.defaultPaddingHorizontal * 0.69),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName
                              .split(' ')
                              .map((word) =>
                                  word.substring(0, 1).toUpperCase() +
                                  word.substring(1).toLowerCase())
                              .join(' '),
                          style: AppStyles.h3p5(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push(AppRouter.settings),
                    icon: const Icon(
                      Icons.settings,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              Text(
                'Datos del usuario',
                style: AppStyles.h4(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSize.defaultPadding * 1.5),
              UserInfoRow(
                title: 'Nombre',
                text: user.fullName,
              ),
              UserInfoRow(
                title: 'Correo electrónico',
                text: user.email,
              ),
              UserInfoRow(
                title: 'Numero de teléfono',
                text: user.phone,
              ),
              SizedBox(height: AppSize.defaultPadding * 1.25),
              DropdownButton<String>(
                // Hace que ocupe todo el ancho
                isExpanded: true,

                // Elimina la línea inferior (underline)
                underline: Container(),

                value: _selectedSection,

                // Personaliza el estilo para que parezca más como un botón o una sección completa
                style: AppStyles.h3(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkColor,
                ),

                hint: Row(
                  children: [
                    const Icon(Icons.bar_chart),
                    SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
                    Text(
                      'Apartados',
                      style: AppStyles.h3(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'usuario',
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text('Sección Usuario')
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'admin',
                    child: Row(
                      children: [
                        Icon(Icons.admin_panel_settings),
                        SizedBox(width: 10),
                        Text('Sección Admin')
                      ],
                    ),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    _selectedSection = value;
                    // Aquí puedes agregar navegación basada en la selección
                    switch (value) {
                      case 'usuario':
                        context.push(AppRouter.home);
                        break;
                      case 'admin':
                        context.push(AppRouter.dashboard);
                        break;
                    }
                  });
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomListTile(
                leadingIcon: const Icon(Icons.bar_chart),
                title: 'Gráficos',
                trailingIcon: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  context.push(AppRouter.editProfile);
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomListTile(
                leadingIcon: const Icon(Icons.my_library_books_rounded),
                title: 'Reportes',
                trailingIcon: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  context.push(AppRouter.editProfile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
