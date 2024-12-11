import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/settings/data/models/public_user.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ConfigView(),
    );
  }
}

class _ConfigView extends StatefulWidget {
  @override
  State<_ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<_ConfigView> {
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
              SizedBox(height: AppSize.defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Lo mas vendido',
                        style: AppStyles.h3p5(
                          color: AppColors.darkColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: AppSize.defaultPaddingHorizontal * 0.2,
                      ), // Espacio entre el texto y la estrella
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 22,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(AppRouter.catalog);
                    },
                    child: Text(
                      'Ver más',
                      style: AppStyles.h4(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.defaultPadding * 0.3,
              ),
              // SizedBox(
              //   height: 0.72.sh,
              //   child: SingleChildScrollView(child: Consumer<ProductProvider>(
              //     builder: (context, productProvider, child) {
              //       if (productProvider.isLoading) {
              //         return const Center(child: CircularProgressIndicator());
              //       }

              //       // Filtra los coches disponibles
              //       final availableProducts = productProvider.availableProducts;

              //       if (availableProducts.isEmpty) {
              //         return const Center(
              //             child: Text('No hay coches disponibles.'));
              //       }

              //       // // Limita a mostrar solo los primeros 4 coches disponibles, o menos si hay menos de 4
              //       // final displayCars = availableProducts.take(4).toList();

              //       return Column(
              //         children: [
              //           ...availableProducts.map((product) => ProductCard(
              //                 imageUrl: product.imageUrl.isEmpty
              //                     ? product.imageUrl[0]
              //                     : '',
              //                 price: product.salePrice.toString(),
              //                 title: product.name,
              //                 //si el color
              //                 circleColor: product.currentStock > 0
              //                     ? Colors.green
              //                     : Colors.red,
              //                 onSelect: () {
              //                   context.push(
              //                     AppRouter.productDetails,
              //                   );
              //                 },
              //               )),
              //           SizedBox(height: AppSize.defaultPadding * 2.5)
              //         ],
              //       );
              //     },
              //   )),
              // ),
              SizedBox(height: AppSize.defaultPadding * 3),
            ],
          ),
        ),
      ),
    );
  }
}
