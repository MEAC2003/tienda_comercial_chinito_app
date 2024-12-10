import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AddSupplierScreen extends StatelessWidget {
  const AddSupplierScreen({super.key});

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
          'Agregar Proveedor',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AddSupplierView(),
    );
  }
}

class _AddSupplierView extends StatefulWidget {
  const _AddSupplierView();

  @override
  State<_AddSupplierView> createState() => _AddSupplierViewState();
}

class _AddSupplierViewState extends State<_AddSupplierView> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankAccountController = TextEditingController();

  @override
  void dispose() {
    _dniController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  Future<void> _saveSupplier() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final success = await context.read<ActionProvider>().createSupplier(
            dni: _dniController.text,
            name: _nameController.text,
            description: _descriptionController.text,
            phone: _phoneController.text,
            bankAccount: _bankAccountController.text,
          );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proveedor creado exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el proveedor: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultPadding * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFields(
                label: 'DNI',
                controller: _dniController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese el DNI';
                  }
                  if (value!.length != 8) {
                    return 'El DNI debe tener 8 dígitos';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Nombre',
                controller: _nameController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Descripción',
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese la descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Teléfono',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese el teléfono';
                  }
                  if (value!.length != 9) {
                    return 'El teléfono debe tener 9 dígitos';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding),
              CustomTextFields(
                label: 'Cuenta Bancaria',
                controller: _bankAccountController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese la cuenta bancaria';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              CustomActionButton(
                text: 'Guardar Proveedor',
                onPressed: _saveSupplier,
                color: AppColors.primarySkyBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
