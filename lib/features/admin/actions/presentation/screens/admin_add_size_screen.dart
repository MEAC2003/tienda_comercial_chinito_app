import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';

class AdminAddSizeScreen extends StatelessWidget {
  const AdminAddSizeScreen({super.key});

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
          'Agregar Talla',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AddSizeView(),
    );
  }
}

class _AddSizeView extends StatefulWidget {
  const _AddSizeView();

  @override
  State<_AddSizeView> createState() => _AddSizeViewState();
}

class _AddSizeViewState extends State<_AddSizeView> {
  final _formKey = GlobalKey<FormState>();
  final _sizeController = TextEditingController();

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  Future<void> _saveSize() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final success = await context.read<ActionProvider>().createSize(
            name: _sizeController.text,
          );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Talla creada exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear la talla: $e')),
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
                label: 'Nombre de la Talla',
                controller: _sizeController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese un nombre para la talla';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              CustomActionButton(
                text: 'Guardar Talla',
                onPressed: _saveSize,
                color: AppColors.primarySkyBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
