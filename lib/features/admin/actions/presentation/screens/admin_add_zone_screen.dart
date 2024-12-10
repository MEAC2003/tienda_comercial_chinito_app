import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
              label: 'Nombre de la Zona',
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            SizedBox(height: AppSize.defaultPadding * 2),
            CustomActionButton(
              text: 'Guardar Zona',
              onPressed: () {
                // TODO: Implement save logic
                print('Guardar zona');
              },
              color: AppColors.primarySkyBlue,
            ),
          ],
        ),
      ),
    );
  }
}
