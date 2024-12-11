import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/settings/presentation/providers/users_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/services/cloudinary_service.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreProductController =
      TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _stockActualController = TextEditingController();
  final TextEditingController _stockMinimoController = TextEditingController();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  String? _selectedCategory;
  String? _selectedTypeGarment;
  String? _selectedSex;
  String? _selectedSize;
  String? _selectedSchool;
  String? _selectedSupplier;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActionProvider>().loadInitialData();
    });
  }

  @override
  void dispose() {
    _nombreProductController.dispose();
    _precioController.dispose();
    _stockActualController.dispose();
    _stockMinimoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final url = await _cloudinaryService.uploadImage();
    if (url != null) {
      setState(() {
        _imageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActionProvider>();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFields(
                label: 'Nombre del Producto',
                controller: _nombreProductController,
                keyboardType: TextInputType.text,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Por favor ingrese un nombre'
                    : null,
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Precio',
                controller: _precioController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese el precio';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Stock actual',
                controller: _stockActualController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese el stock actual';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Stock mínimo',
                controller: _stockMinimoController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese el stock mínimo';
                  }
                  if (int.tryParse(value!) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              Text(
                'Categoría',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text(
                  'Selecciona la categoría',
                  style: AppStyles.h5(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                items: provider.categories.map((category) {
                  return DropdownMenuItem(
                    value: category.id.toString(),
                    child: Text(
                      category.name,
                      style: AppStyles.h5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator: (value) =>
                    value == null ? 'Seleccione una categoría' : null,
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              // Type Garment Dropdown
              Text(
                'Tipo de prenda',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Selecciona el tipo de prenda',
                  style: AppStyles.h5(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _selectedTypeGarment,
                items: provider.typeGarments.map((type) {
                  return DropdownMenuItem(
                    value: type.id,
                    child: Text(
                      type.name,
                      style: AppStyles.h5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => _selectedTypeGarment = value),
                validator: (value) =>
                    value == null ? 'Seleccione un tipo' : null,
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              // Sex Dropdown
              Text(
                'Sexo',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Selecciona el sexo',
                  style: AppStyles.h5(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _selectedSex,
                items: provider.sexes.map((sex) {
                  return DropdownMenuItem(
                    value: sex.id.toString(),
                    child: Text(
                      sex.name,
                      style: AppStyles.h5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedSex = value),
                validator: (value) =>
                    value == null ? 'Seleccione el sexo' : null,
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              // Size Dropdown
              Text(
                'Talla',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Selecciona la talla',
                  style: AppStyles.h5(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _selectedSize,
                items: provider.sizes.map((size) {
                  return DropdownMenuItem(
                    value: size.id.toString(),
                    child: Text(
                      size.name,
                      style: AppStyles.h5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedSize = value),
                validator: (value) =>
                    value == null ? 'Seleccione una talla' : null,
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              // School Dropdown
              Text(
                'Colegio',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Selecciona el colegio',
                  style: AppStyles.h5(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _selectedSchool,
                items: provider.schools.map((school) {
                  return DropdownMenuItem(
                    value: school.id,
                    child: Text(
                      school.name,
                      style: AppStyles.h5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedSchool = value),
                validator: (value) =>
                    value == null ? 'Seleccione un colegio' : null,
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              // Supplier Dropdown
              Text(
                'Proveedor',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Selecciona el proveedor',
                  style: AppStyles.h5(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _selectedSupplier,
                items: provider.suppliers.map((supplier) {
                  return DropdownMenuItem(
                    value: supplier.id,
                    child: Text(
                      supplier.name,
                      style: AppStyles.h5(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedSupplier = value),
                validator: (value) =>
                    value == null ? 'Seleccione un proveedor' : null,
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              // Image picker
              Text(
                'Imagen',
                style: AppStyles.h4(
                  color: AppColors.primarySkyBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSize.defaultPadding),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageUrl != null
                      ? Image.network(_imageUrl!, fit: BoxFit.cover)
                      : Icon(Icons.camera_alt_outlined,
                          size: 40, color: AppColors.darkColor50),
                ),
              ),

              SizedBox(height: AppSize.defaultPadding * 2),

              CustomActionButton(
                text: 'Guardar Producto',
                onPressed: _saveProduct,
                color: AppColors.primarySkyBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor seleccione una imagen')),
      );
      return;
    }

    try {
      final userId = context.read<UserProvider>().user?.id;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Usuario no identificado')),
        );
        return;
      }
      final success = await context.read<ActionProvider>().createProduct(
            name: _nombreProductController.text,
            imageUrls: [_imageUrl!],
            salePrice: double.parse(_precioController.text),
            currentStock: int.parse(_stockActualController.text),
            minimumStock: int.parse(_stockMinimoController.text),
            typeGarmentId: _selectedTypeGarment!,
            supplierId: _selectedSupplier!,
            schoolId: _selectedSchool!,
            sizeId: int.parse(_selectedSize!),
            categoryId: int.parse(_selectedCategory!),
            sexId: int.parse(_selectedSex!),
            userId: userId,
          );

      if (success) {
        await context.read<ActionProvider>().loadInitialData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto creado exitosamente')),
        );
        context.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el producto: $e')),
      );
    }
  }
}
