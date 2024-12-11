import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminTypeGarmentUpdateScreen extends StatefulWidget {
  final String typeGarmentId;
  const AdminTypeGarmentUpdateScreen({super.key, required this.typeGarmentId});

  @override
  State<AdminTypeGarmentUpdateScreen> createState() =>
      _AdminTypeGarmentUpdateScreenState();
}

class _AdminTypeGarmentUpdateScreenState
    extends State<AdminTypeGarmentUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  TypeGarment? _typeGarment;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ActionProvider>();
      final typeGarment = provider.typeGarments.firstWhere(
        (t) => t.id == widget.typeGarmentId,
        orElse: () => TypeGarment(id: '', name: ''),
      );

      setState(() {
        _typeGarment = typeGarment;
        _nameController.text = typeGarment.name;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateTypeGarment() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<ActionProvider>();
      final success = await provider.updateTypeGarment(
        id: widget.typeGarmentId,
        name: _nameController.text,
      );

      if (!mounted) return;

      if (success) {
        await provider.loadInitialData();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Tipo de prenda actualizado exitosamente')),
        );
        if (context.canPop()) {
          context.pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al actualizar el tipo de prenda')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el tipo de prenda: $e')),
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
          'Actualizar Tipo de Prenda',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _typeGarment == null
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSize.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID del Tipo de Prenda',
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
                        widget.typeGarmentId,
                        style: AppStyles.h4(color: AppColors.darkColor),
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 2),
                    CustomTextFields(
                      label: 'Nombre del Tipo de Prenda',
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
                      text: 'Actualizar Tipo de Prenda',
                      onPressed: _updateTypeGarment,
                      color: AppColors.primarySkyBlue,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
