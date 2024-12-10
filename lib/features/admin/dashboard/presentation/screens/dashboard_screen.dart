import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/presentation/widgets/widget.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  @override
  void initState() {
    super.initState();
    // Load stats when screen initializes
    Future.microtask(
        () => context.read<DashboardProvider>().loadProductStats());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final dashboardProvider = context.watch<DashboardProvider>();
    final PublicUser? user = userProvider.user;
    final userName = user?.fullName ?? '';
    final firstName = userName.split(' ')[0];
    if (userProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userProvider.error != null) {
      return Center(child: Text('Error: ${userProvider.error}'));
    }

    // If user is null, show a message
    if (user == null) {
      return const Center(child: Text('No user data available'));
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultPadding * 1.5),
          child: Column(
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
                        Row(
                          children: [
                            Text(
                              firstName
                                  .split(' ')
                                  .map((word) =>
                                      word.substring(0, 1).toUpperCase() +
                                      word.substring(1).toLowerCase())
                                  .join(' '),
                              style: AppStyles.h3p5(
                                color: AppColors.darkColor,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              user.role == 'admin'
                                  ? 'Administrador'
                                  : 'Usuario',
                              style: AppStyles.h4(
                                color: AppColors.darkColor50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push(AppRouter.adminMyAccount),
                    icon: const Icon(
                      Icons.notifications_none,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.defaultPadding * 1.25),
              Container(
                width: double.infinity,
                height: 146.h,
                margin: EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                child: ClipRRect(
                  // Para mantener los bordes redondeados
                  borderRadius:
                      BorderRadius.circular(AppSize.defaultRadius * 1.5),
                  child: Image.asset(
                    AppAssets.banner,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('Error al cargar la imagen'),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // SizedBox(height: AppSize.defaultPadding * 0.4),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(
              //     4,
              //     (index) => Container(
              //       margin: EdgeInsets.only(right: AppSize.defaultPadding / 2),
              //       width: index == 0 ? 24.w : 8.w,
              //       height: 8,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(4),
              //         color: index == 0
              //             ? AppColors.primarySkyBlue
              //             : Colors.grey.withOpacity(0.3),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: AppSize.defaultPadding * 2),
              Row(
                children: [
                  const Icon(Icons.bar_chart),
                  SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
                  Text(
                    'Estadísticas',
                    style: AppStyles.h3(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.defaultPadding),
              dashboardProvider.isLoading
                  ? const CircularProgressIndicator()
                  : QuickStatsRow(
                      products: dashboardProvider.totalProducts,
                      lowStock: dashboardProvider.lowStockProducts,
                      mediumStock: dashboardProvider.mediumStockProducts,
                    ),
              SizedBox(height: AppSize.defaultPadding * 2),
              Row(
                children: [
                  const Icon(Icons.flash_auto),
                  SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
                  Text(
                    'Acciones rápidas',
                    style: AppStyles.h3(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuickAction(
                    label: 'Productos',
                    icon: Icons.grid_view,
                    onTap: () => context.push(AppRouter.adminActions),
                  ),
                  QuickAction(
                    label: 'Nuevo producto',
                    icon: Icons.group_add,
                    onTap: () => context.push(AppRouter.adminAddProduct),
                  ),
                  QuickAction(
                    label: 'Nuevo proveedor',
                    icon: Icons.groups,
                    onTap: () => context.push(AppRouter.adminAddSupplier),
                  ),
                  QuickAction(
                    label: 'Roles',
                    icon: Icons.manage_accounts,
                    onTap: () => context.push(AppRouter.adminRoles),
                  ),
                ],
              ),
              //Egresos mensual
              SizedBox(height: AppSize.defaultPadding * 2),
              Row(
                children: [
                  const Icon(Icons.graphic_eq),
                  SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
                  Text(
                    'Egresos mensuales',
                    style: AppStyles.h3(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.defaultPadding),
              const ExpensesChart(),
              SizedBox(height: AppSize.defaultPadding * 4),
            ],
          ),
        ),
      ),
    );
  }
}
