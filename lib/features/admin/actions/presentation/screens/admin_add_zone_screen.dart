import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AddZoneScreen extends StatelessWidget {
  const AddZoneScreen({super.key});

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
          'Agregar Zona',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AddZoneView(),
    );
  }
}

class _AddZoneView extends StatefulWidget {
  const _AddZoneView();

  @override
  State<_AddZoneView> createState() => _AddZoneViewState();
}

class _AddZoneViewState extends State<_AddZoneView> {
  final _formKey = GlobalKey<FormState>();
  final _zoneController = TextEditingController();

  @override
  void dispose() {
    _zoneController.dispose();
    super.dispose();
  }

  Future<void> _saveZone() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final success = await context.read<ActionProvider>().createZone(
            name: _zoneController.text,
          );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Zona creada exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear la zona: $e')),
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
                label: 'Nombre de la Zona',
                controller: _zoneController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor ingrese un nombre para la zona';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.defaultPadding * 2),
              CustomActionButton(
                text: 'Guardar Zona',
                onPressed: _saveZone,
                color: AppColors.primarySkyBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
