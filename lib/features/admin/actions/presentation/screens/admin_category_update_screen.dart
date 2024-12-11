import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/categories.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminCategoryUpdateScreen extends StatefulWidget {
  final String categoryId;
  const AdminCategoryUpdateScreen({super.key, required this.categoryId});

  @override
  State<AdminCategoryUpdateScreen> createState() =>
      _AdminCategoryUpdateScreenState();
}

class _AdminCategoryUpdateScreenState extends State<AdminCategoryUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Categories? _category;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ActionProvider>();
      final category = provider.categories.firstWhere(
        (c) => c.id.toString() == widget.categoryId,
        orElse: () => Categories(id: 0, name: ''),
      );

      setState(() {
        _category = category;
        _nameController.text = category.name;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateCategory() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<ActionProvider>();
      final success = await provider.updateCategory(
        id: widget.categoryId,
        name: _nameController.text,
      );

      if (!mounted) return;

      if (success) {
        await provider.loadInitialData();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Categoría actualizada exitosamente')),
        );
        if (context.canPop()) {
          context.pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar la categoría')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la categoría: $e')),
      );
    }
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
          'Actualizar Categoría',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _category == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(AppSize.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID de la Categoría',
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
                          widget.categoryId,
                          style: AppStyles.h4(color: AppColors.darkColor),
                        ),
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomTextFields(
                        label: 'Nombre de la Categoría',
                        controller: _nameController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor ingrese un nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomActionButton(
                        text: 'Actualizar Categoría',
                        onPressed: _updateCategory,
                        color: AppColors.primarySkyBlue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
