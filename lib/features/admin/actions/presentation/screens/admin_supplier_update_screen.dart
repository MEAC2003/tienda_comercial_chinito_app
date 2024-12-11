import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminSupplierUpdateScreen extends StatefulWidget {
  final String supplierId;
  const AdminSupplierUpdateScreen({super.key, required this.supplierId});

  @override
  State<AdminSupplierUpdateScreen> createState() =>
      _AdminSupplierUpdateScreenState();
}

class _AdminSupplierUpdateScreenState extends State<AdminSupplierUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dniController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneController;
  late TextEditingController _bankAccountController;
  Suppliers? _supplier;

  @override
  void initState() {
    super.initState();
    _dniController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _phoneController = TextEditingController();
    _bankAccountController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<ActionProvider>();
      final supplier = await provider.getSupplierById(widget.supplierId);

      if (supplier != null) {
        setState(() {
          _supplier = supplier;
          _dniController.text = supplier.dni;
          _nameController.text = supplier.name;
          _descriptionController.text = supplier.description;
          _phoneController.text = supplier.phone;
          _bankAccountController.text = supplier.bankAccount;
        });
      }
    });
  }

  @override
  void dispose() {
    _dniController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  Future<void> _updateSupplier() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<ActionProvider>();
      final success = await provider.updateSupplier(
        id: widget.supplierId,
        dni: _dniController.text,
        name: _nameController.text,
        description: _descriptionController.text,
        phone: _phoneController.text,
        bankAccount: _bankAccountController.text,
      );

      if (!mounted) return;

      if (success) {
        await provider.loadInitialData();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proveedor actualizado exitosamente')),
        );
        if (context.canPop()) {
          context.pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el proveedor')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el proveedor: $e')),
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
          'Actualizar Proveedor',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _supplier == null
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppSize.defaultPadding * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID del Proveedor',
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
                          widget.supplierId,
                          style: AppStyles.h4(color: AppColors.darkColor),
                        ),
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomTextFields(
                        label: 'DNI',
                        controller: _dniController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true)
                            return 'Por favor ingrese el DNI';
                          if (value!.length != 8)
                            return 'El DNI debe tener 8 dígitos';
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.defaultPadding),
                      CustomTextFields(
                        label: 'Nombre',
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Por favor ingrese el nombre'
                            : null,
                      ),
                      SizedBox(height: AppSize.defaultPadding),
                      CustomTextFields(
                        label: 'Descripción',
                        controller: _descriptionController,
                        keyboardType: TextInputType.text,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Por favor ingrese la descripción'
                            : null,
                      ),
                      SizedBox(height: AppSize.defaultPadding),
                      CustomTextFields(
                        label: 'Teléfono',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true)
                            return 'Por favor ingrese el teléfono';
                          if (value!.length != 9)
                            return 'El teléfono debe tener 9 dígitos';
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.defaultPadding),
                      CustomTextFields(
                        label: 'Cuenta Bancaria',
                        controller: _bankAccountController,
                        keyboardType: TextInputType.text,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Por favor ingrese la cuenta bancaria'
                            : null,
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomActionButton(
                        text: 'Actualizar Proveedor',
                        onPressed: _updateSupplier,
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
