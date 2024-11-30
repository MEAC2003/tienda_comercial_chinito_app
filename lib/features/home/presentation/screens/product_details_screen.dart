import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/widgets/widgets.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5.w),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Detalle del producto',
          style: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  const _ProductDetailsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProductImageCarousel(),
                SizedBox(
                  height: AppSize.defaultPadding * 1.5,
                ),
                Text(
                  'Colegio San José',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: AppSize.defaultPadding / 2,
                ),
                Text(
                  'Camisa manga corta',
                  style: AppStyles.h2(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: AppSize.defaultPadding / 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'S/. 50.00',
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '+ 6',
                      style: AppStyles.h3p5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Text(
                  'Categoría: TEENS',
                  style: AppStyles.h3(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: AppSize.defaultPadding,
                ),
                SizeSelector(
                  onSizeSelected: (String size) {
                    print('Talla seleccionada: $size');
                    // Aquí puedes manejar la selección de la talla
                  },
                ),
                SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Disponible: 2',
                      style: AppStyles.h3(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //elegir cuantos productos se quieren - 1 +
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Menos producto');
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.darkColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: AppColors.darkColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Más producto');
                          },
                          child: const SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.add,
                              color: AppColors.darkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.defaultPadding * 2,
                ),
                CustomActionButton(
                  text: 'Confirmar pedido',
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
