import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminActionsScreen extends StatelessWidget {
  const AdminActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Acciones',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AdminActionsView(),
    );
  }
}

class _AdminActionsView extends StatefulWidget {
  const _AdminActionsView();

  @override
  State<_AdminActionsView> createState() => _AdminActionsViewState();
}

class _AdminActionsViewState extends State<_AdminActionsView> {
  @override
  Widget build(BuildContext context) {
    String? _selectedOption;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPaddingHorizontal * 1.5),
        child: Column(
          children: [
            SizedBox(height: AppSize.defaultPadding * 1.5),
            //View
            DropdownButton<String>(
              isExpanded: true,
              underline: Container(),
              value: _selectedOption,
              style: AppStyles.h3(
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              hint: Row(
                children: [
                  const Icon(Icons.remove_red_eye),
                  SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
                  Text(
                    'Ver',
                    style: AppStyles.h3(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
              items: [
                DropdownMenuItem(
                  value: 'productos',
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Productos')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'proveedores',
                  child: Row(
                    children: [
                      const Icon(Icons.business),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Proveedores')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'colegios',
                  child: Row(
                    children: [
                      const Icon(Icons.school),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Colegios')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'zonas',
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Zonas')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'categorias',
                  child: Row(
                    children: [
                      const Icon(Icons.category),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Categorías')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'tipos_prenda',
                  child: Row(
                    children: [
                      const Icon(Icons.checkroom),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Tipos de Prenda')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'tallas',
                  child: Row(
                    children: [
                      const Icon(Icons.straighten),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Tallas')
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  switch (value) {
                    case 'productos':
                      // context.push(AppRouter.adminAddProduct);
                      break;
                    case 'proveedores':
                      break;
                    case 'colegios':
                      break;
                    case 'zonas':
                      break;
                    case 'categorias':
                      break;
                    case 'tipos_prenda':
                      break;
                    case 'tallas':
                      break;
                  }
                });
              },
            ),
            //Add
            SizedBox(height: AppSize.defaultPadding),
            DropdownButton<String>(
              isExpanded: true,
              underline: Container(),
              value: _selectedOption,
              style: AppStyles.h3(
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
              hint: Row(
                children: [
                  const Icon(Icons.add),
                  SizedBox(width: AppSize.defaultPaddingHorizontal * 0.2),
                  Text(
                    'Agregar',
                    style: AppStyles.h3(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
              items: [
                DropdownMenuItem(
                  value: 'producto',
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Producto')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'proveedore',
                  child: Row(
                    children: [
                      const Icon(Icons.business),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Proveedore')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'colegio',
                  child: Row(
                    children: [
                      const Icon(Icons.school),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Colegio')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'zona',
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Zona')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'categoria',
                  child: Row(
                    children: [
                      const Icon(Icons.category),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Categoría')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'tipos_prenda',
                  child: Row(
                    children: [
                      const Icon(Icons.checkroom),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Tipos de Prenda')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'talla',
                  child: Row(
                    children: [
                      const Icon(Icons.straighten),
                      SizedBox(width: AppSize.defaultPaddingHorizontal * 0.65),
                      const Text('Talla')
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(
                  () {
                    _selectedOption = value;
                    switch (value) {
                      case 'producto':
                        context.push(AppRouter.adminAddProduct);
                        break;
                      case 'proveedore':
                        context.push(AppRouter.adminAddSupplier);
                        break;
                      case 'colegio':
                        context.push(AppRouter.adminAddSchool);
                        break;
                      case 'zona':
                        context.push(AppRouter.adminAddZone);
                        break;
                      case 'categoria':
                        context.push(AppRouter.adminAddCategory);
                        break;
                      case 'tipos_prenda':
                        context.push(AppRouter.adminAddTypeGarment);
                        break;
                      case 'talla':
                        context.push(AppRouter.adminAddSize);
                        break;
                    }
                  },
                );
              },
            ),
            SizedBox(height: AppSize.defaultPadding),
            //inventario de movimientos
            CustomListTile(
              trailingIcon: const Icon(Icons.arrow_forward_ios),
              leadingIcon: const Icon(Icons.inventory),
              title: 'Inventario de Movimientos',
              onTap: () {
                context.push(AppRouter.adminInventoryMovements);
              },
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomListTile(
              trailingIcon: const Icon(Icons.arrow_forward_ios),
              leadingIcon: const Icon(Icons.person),
              title: 'Roles de Administrador',
              onTap: () {
                context.push(AppRouter.adminRoles);
              },
            ),
          ],
        ),
      ),
    );
  }
}
