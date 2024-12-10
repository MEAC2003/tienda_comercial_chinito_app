import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

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
          'Agregar Categoría',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AddCategoryView(),
    );
  }
}

class _AddCategoryView extends StatefulWidget {
  const _AddCategoryView();

  @override
  State<_AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<_AddCategoryView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final success = await context.read<ActionProvider>().createCategory(
            name: _nameController.text,
          );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Categoría creada exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear la categoría: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              text: 'Guardar Categoría',
              onPressed: _saveCategory,
              color: AppColors.primarySkyBlue,
            ),
          ],
        ),
      ),
    ));
  }
}
