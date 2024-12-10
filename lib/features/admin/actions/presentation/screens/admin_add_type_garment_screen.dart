import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';

class AdminAddTypeGarmentScreen extends StatelessWidget {
  const AdminAddTypeGarmentScreen({super.key});

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
        title: Text(
          'Agregar Tipo de Prenda',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _AddTypeGarmentView(),
    );
  }
}

class _AddTypeGarmentView extends StatefulWidget {
  const _AddTypeGarmentView();

  @override
  State<_AddTypeGarmentView> createState() => _AddTypeGarmentViewState();
}

class _AddTypeGarmentViewState extends State<_AddTypeGarmentView> {
  final TextEditingController _typeController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
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
              label: 'Nombre del Tipo de Prenda',
              controller: _typeController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un tipo de prenda';
                }
                return null;
              },
            ),
            SizedBox(height: AppSize.defaultPadding * 2),
            CustomActionButton(
              text: 'Guardar Tipo de Prenda',
              onPressed: () {
                // TODO: Implement save logic
                print('Guardar tipo de prenda');
              },
              color: AppColors.primarySkyBlue,
            ),
          ],
        ),
      ),
    );
  }
}
