import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/products.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sex.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/home/presentation/providers/product_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/services/cloudinary_service.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminProductUpdate extends StatefulWidget {
  final String productId;
  const AdminProductUpdate({super.key, required this.productId});

  @override
  State<AdminProductUpdate> createState() => _AdminProductUpdateState();
}

class _AdminProductUpdateState extends State<AdminProductUpdate> {
  final _formKey = GlobalKey<FormState>();
  bool _isUploadingImage = false;
  late TextEditingController _nombreProductController;
  late TextEditingController _precioController;
  late TextEditingController _stockActualController;
  late TextEditingController _stockMinimoController;
  final CloudinaryService _cloudinaryService = CloudinaryService();

  String? _selectedCategory;
  String? _selectedTypeGarment;
  String? _selectedSex;
  String? _selectedSize;
  String? _selectedSchool;
  String? _selectedSupplier;
  String? _imageUrl;
  Products? _product;

  @override
  void initState() {
    super.initState();
    _nombreProductController = TextEditingController();
    _precioController = TextEditingController();
    _stockActualController = TextEditingController();
    _stockMinimoController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<ActionProvider>();
      await provider.loadInitialData();
      _product = await provider.getProductById(widget.productId);

      if (_product != null) {
        setState(() {
          _nombreProductController.text = _product!.name;
          _precioController.text = _product!.salePrice.toString();
          _stockActualController.text = _product!.currentStock.toString();
          _stockMinimoController.text = _product!.minimumStock.toString();
          _selectedCategory = _product!.categoryId.toString();
          _selectedTypeGarment = _product!.typeGarmentId;
          _selectedSex = _product!.sexId.toString();
          _selectedSize = _product!.sizeId.toString();
          _selectedSchool = _product!.schoolId;
          _selectedSupplier = _product!.supplierId;
          _imageUrl =
              _product!.imageUrl.isNotEmpty ? _product!.imageUrl.first : null;
        });
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      setState(() => _isUploadingImage = true);

      final url = await _cloudinaryService.uploadImage();

      if (!mounted) return;

      if (url != null) {
        setState(() {
          _imageUrl = url;
          _isUploadingImage = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() => _isUploadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir imagen: $e')),
      );
    }
  }

  Widget _buildImageWidget() {
    if (_isUploadingImage) {
      return const Center(child: CircularProgressIndicator());
    }
    return _imageUrl != null
        ? Image.network(_imageUrl!, fit: BoxFit.cover)
        : Icon(Icons.camera_alt_outlined,
            size: 40, color: AppColors.darkColor50);
  }

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
          'Actualizar Producto',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        if (_product == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSize.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID del Producto',
                  style: AppStyles.h4(
                    color: AppColors.primarySkyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(AppSize.defaultPadding),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.productId,
                    style: AppStyles.h4(color: AppColors.darkColor),
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding * 2),
                CustomTextFields(
                  label: 'Nombre del Producto',
                  controller: _nombreProductController,
                  keyboardType: TextInputType.text,
                  hintText: _product?.name,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Por favor ingrese un nombre'
                      : null,
                ),
                SizedBox(height: AppSize.defaultPadding),
                CustomTextFields(
                  label: 'Precio',
                  controller: _precioController,
                  keyboardType: TextInputType.number,
                  hintText: _product?.salePrice.toString(),
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Por favor ingrese el precio';
                    if (double.tryParse(value!) == null)
                      return 'Ingrese un número válido';
                    return null;
                  },
                ),
                SizedBox(height: AppSize.defaultPadding),
                CustomTextFields(
                  label: 'Stock actual',
                  controller: _stockActualController,
                  keyboardType: TextInputType.number,
                  hintText: _product?.currentStock.toString(),
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Por favor ingrese el stock actual';
                    if (int.tryParse(value!) == null)
                      return 'Ingrese un número válido';
                    return null;
                  },
                ),
                SizedBox(height: AppSize.defaultPadding),
                CustomTextFields(
                  label: 'Stock mínimo',
                  controller: _stockMinimoController,
                  keyboardType: TextInputType.number,
                  hintText: _product?.minimumStock.toString(),
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return 'Por favor ingrese el stock mínimo';
                    if (int.tryParse(value!) == null)
                      return 'Ingrese un número válido';
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
                    'Categoría actual: ${provider.categories.firstWhere((c) => c.id.toString() == _product?.categoryId.toString(), orElse: () => Categories(id: 0, name: 'No encontrada')).name}',
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
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value),
                  validator: (value) =>
                      value == null ? 'Seleccione una categoría' : null,
                ),
                SizedBox(height: AppSize.defaultPadding * 2),
                Text(
                  'Tipo de prenda',
                  style: AppStyles.h4(
                    color: AppColors.primarySkyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedTypeGarment,
                  hint: Text(
                    'Tipo actual: ${provider.typeGarments.firstWhere((t) => t.id == _product?.typeGarmentId, orElse: () => TypeGarment(id: '', name: 'No encontrado')).name}',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                Text(
                  'Sexo',
                  style: AppStyles.h4(
                    color: AppColors.primarySkyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSex,
                  hint: Text(
                    'Sexo actual: ${provider.sexes.firstWhere((s) => s.id.toString() == _product?.sexId.toString(), orElse: () => Sex(id: 0, name: 'No encontrado', createdAt: DateTime.now().toIso8601String())).name}',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                Text(
                  'Talla',
                  style: AppStyles.h4(
                    color: AppColors.primarySkyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSize,
                  hint: Text(
                    'Talla actual: ${provider.sizes.firstWhere((s) => s.id.toString() == _product?.sizeId.toString(), orElse: () => Sizes(id: 0, name: 'No encontrada')).name}',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                Text(
                  'Colegio',
                  style: AppStyles.h4(
                    color: AppColors.primarySkyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSchool,
                  hint: Text(
                    'Colegio actual: ${provider.schools.firstWhere((s) => s.id == _product?.schoolId, orElse: () => Schools(id: '', name: 'No encontrado', level: '', zoneId: '')).name}',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                Text(
                  'Proveedor',
                  style: AppStyles.h4(
                    color: AppColors.primarySkyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSupplier,
                  hint: Text(
                    'Proveedor actual: ${provider.suppliers.firstWhere((s) => s.id == _product?.supplierId, orElse: () => Suppliers(id: '', name: 'No encontrado', dni: '', description: '', phone: '', bankAccount: '')).name}',
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                  onChanged: (value) =>
                      setState(() => _selectedSupplier = value),
                  validator: (value) =>
                      value == null ? 'Seleccione un proveedor' : null,
                ),
                SizedBox(height: AppSize.defaultPadding * 2),
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
                  text: 'Actualizar Producto',
                  onPressed: _updateProduct,
                  color: AppColors.primarySkyBlue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      final success = await context.read<ActionProvider>().updateProduct(
            id: widget.productId,
            name: _nombreProductController.text,
            imageUrls: [_imageUrl ?? _product!.imageUrl.first],
            salePrice: double.parse(_precioController.text),
            currentStock: int.parse(_stockActualController.text),
            minimumStock: int.parse(_stockMinimoController.text),
            typeGarmentId: _selectedTypeGarment!,
            supplierId: _selectedSupplier!,
            schoolId: _selectedSchool!,
            sizeId: int.parse(_selectedSize!),
            categoryId: int.parse(_selectedCategory!),
            sexId: int.parse(_selectedSex!),
          );
      if (success && mounted) {
        await context.read<ProductProvider>().refreshProducts();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto actualizado exitosamente')),
        );
        context.pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el producto: $e')),
      );
    }
  }
}
