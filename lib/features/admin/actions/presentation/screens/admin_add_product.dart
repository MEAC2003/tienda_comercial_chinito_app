import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

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
          'Agregar Producto',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AdminAssProductView(),
    );
  }
}

class _AdminAssProductView extends StatefulWidget {
  const _AdminAssProductView();

  @override
  State<_AdminAssProductView> createState() => _AdminAssProductViewState();
}

class _AdminAssProductViewState extends State<_AdminAssProductView> {
  final TextEditingController _inventarioController = TextEditingController();
  String? _selectedColegio;
  @override
  void initState() {
    super.initState();
    _inventarioController.text = 'sv25233231'; // Valor predeterminado.
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre del Producto',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: _inventarioController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: AppStyles.h5(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Precio',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: _inventarioController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: AppStyles.h5(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Stock actual',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: _inventarioController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: AppStyles.h5(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Stock mínimo',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: _inventarioController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: AppStyles.h5(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            // Campo para categoría
            Text(
              'Categoría',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la opción',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedColegio,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedColegio = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Categoria 1',
                  child: Text(
                    'Categoria 1',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Categoria 2',
                  child: Text(
                    'Categoria 2',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Categoria 3',
                  child: Text(
                    'Categoria 3',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Tipo de Prenda',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la opción',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedColegio,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedColegio = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Prenda 1',
                  child: Text(
                    'Prenda 1',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Prenda 2',
                  child: Text(
                    'Prenda 2',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Prenda 3',
                  child: Text(
                    'Prenda 3',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Sexo',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la opción',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedColegio,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedColegio = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Sexo 1',
                  child: Text(
                    'Sexo 1',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Sexo 2',
                  child: Text(
                    'Sexo 2',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Sexo 3',
                  child: Text(
                    'Sexo  3',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Talla',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la opción',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedColegio,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedColegio = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Talla 1',
                  child: Text(
                    'Colegio 1',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Talla 2',
                  child: Text(
                    'Talla 2',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Talla 3',
                  child: Text(
                    'Talla 3',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            // Campo para Colegio-Id
            Text(
              'Colegio',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la opción',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedColegio,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedColegio = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Colegio 1',
                  child: Text(
                    'Colegio 1',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Colegio 2',
                  child: Text(
                    'Colegio 2',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Colegio 3',
                  child: Text(
                    'Colegio 3',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            // Campo para supplier
            Text(
              'Proveedor',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la opción',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedColegio,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedColegio = newValue;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Proveedor 1',
                  child: Text(
                    'Proveedor 1',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Proveedor 2',
                  child: Text(
                    'Proveedor 2',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Proveedor 3',
                  child: Text(
                    'Proveedor 3',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Producto-Imagen',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Contenedor de la imagen
            SizedBox(height: AppSize.defaultPadding),
            GestureDetector(
              onTap: () {
                // Aquí puedes agregar la funcionalidad para seleccionar una imagen.
                print('Seleccionar imagen');
              },
              child: Container(
                width: double.infinity,
                height: 150, // Altura deseada
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Color del borde
                  ),
                  borderRadius:
                      BorderRadius.circular(8), // Bordes redondeados opcionales
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                    color: AppColors.darkColor50,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.defaultPadding * 2),
            CustomActionButton(
                text: 'Siguiente',
                onPressed: () {},
                color: AppColors.primarySkyBlue),
          ],
        ),
      ),
    );
  }
}
