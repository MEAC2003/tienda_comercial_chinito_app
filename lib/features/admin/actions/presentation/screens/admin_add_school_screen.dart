import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AddSchoolScreen extends StatelessWidget {
  const AddSchoolScreen({super.key});

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
          'Agregar Colegio',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AddSchoolView(),
    );
  }
}

class _AddSchoolView extends StatefulWidget {
  const _AddSchoolView();

  @override
  State<_AddSchoolView> createState() => _AddSchoolViewState();
}

class _AddSchoolViewState extends State<_AddSchoolView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedZone;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActionProvider>().loadInitialData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveSchool() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final success = await context.read<ActionProvider>().createSchool(
            name: _nameController.text,
            description: _descriptionController.text,
            zoneId: _selectedZone!,
          );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Colegio creado exitosamente')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el colegio: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActionProvider>();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFields(
              label: 'Nombre del Colegio',
              controller: _nameController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Por favor ingrese un nombre' : null,
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomTextFields(
              label: 'Nivel del Colegio',
              controller: _descriptionController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Por favor ingrese el nivel' : null,
            ),
            SizedBox(height: AppSize.defaultPadding),
            Text(
              'Zona',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedZone,
              hint: Text(
                'Selecciona la zona',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              items: provider.zones.map((zone) {
                return DropdownMenuItem(
                  value: zone.id,
                  child: Text(
                    zone.name,
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedZone = value),
              validator: (value) =>
                  value == null ? 'Seleccione una zona' : null,
            ),
            SizedBox(height: AppSize.defaultPadding * 2),
            CustomActionButton(
              text: 'Guardar Colegio',
              onPressed: _saveSchool,
              color: AppColors.primarySkyBlue,
            ),
          ],
        ),
      ),
    );
  }
}
