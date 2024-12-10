import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedZone;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFields(
              label: 'Nombre del Colegio',
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            SizedBox(height: AppSize.defaultPadding),
            CustomTextFields(
              label: 'Nivel del Colegio',
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
            SizedBox(height: AppSize.defaultPadding),
            // Zona Dropdown
            Text(
              'Zona',
              style: AppStyles.h4(
                color: AppColors.primarySkyBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButtonFormField<String>(
              hint: Text(
                'Selecciona la zona',
                style: AppStyles.h5(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: _selectedZone,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedZone = newValue;
                });
              },
              items: ['Zona 1', 'Zona 2', 'Zona 3', 'Zona 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppStyles.h5(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),

            SizedBox(height: AppSize.defaultPadding * 2),
            CustomActionButton(
              text: 'Guardar Colegio',
              onPressed: () {
                // TODO: Implement save logic
                print('Guardar colegio');
              },
              color: AppColors.primarySkyBlue,
            ),
          ],
        ),
      ),
    );
  }
}
