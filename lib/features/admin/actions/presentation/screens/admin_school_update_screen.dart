import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminSchoolUpdateScreen extends StatefulWidget {
  final String schoolId;
  const AdminSchoolUpdateScreen({super.key, required this.schoolId});

  @override
  State<AdminSchoolUpdateScreen> createState() =>
      _AdminSchoolUpdateScreenState();
}

class _AdminSchoolUpdateScreenState extends State<AdminSchoolUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _levelController;
  String? _selectedZone;
  Schools? _school;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _levelController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<ActionProvider>();
      await provider.loadInitialData();

      final school = provider.schools.firstWhere(
        (s) => s.id == widget.schoolId,
        orElse: () => Schools(id: '', name: '', level: '', zoneId: ''),
      );

      setState(() {
        _school = school;
        _nameController.text = school.name;
        _levelController.text = school.level;
        _selectedZone = school.zoneId;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  Future<void> _updateSchool() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<ActionProvider>();
      final success = await provider.updateSchool(
        id: widget.schoolId,
        name: _nameController.text,
        level: _levelController.text,
        zoneId: _selectedZone!,
      );

      if (!mounted) return;

      if (success) {
        await provider.loadInitialData();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Colegio actualizado exitosamente')),
        );
        if (context.canPop()) {
          context.pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el colegio')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el colegio: $e')),
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
          'Actualizar Colegio',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _school == null
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSize.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID del Colegio',
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
                        widget.schoolId,
                        style: AppStyles.h4(color: AppColors.darkColor),
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 2),
                    CustomTextFields(
                      label: 'Nombre del Colegio',
                      controller: _nameController,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Por favor ingrese un nombre'
                          : null,
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    CustomTextFields(
                      label: 'Nivel del Colegio',
                      controller: _levelController,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Por favor ingrese el nivel'
                          : null,
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    Consumer<ActionProvider>(
                      builder: (context, provider, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            onChanged: (value) =>
                                setState(() => _selectedZone = value),
                            validator: (value) =>
                                value == null ? 'Seleccione una zona' : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding * 2),
                    CustomActionButton(
                      text: 'Actualizar Colegio',
                      onPressed: _updateSchool,
                      color: AppColors.primarySkyBlue,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
