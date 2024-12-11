import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/type_garment.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminDetailTypeGarmentScreen extends StatelessWidget {
  final String typeGarmentId;
  const AdminDetailTypeGarmentScreen({super.key, required this.typeGarmentId});

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
          'Detalle de Tipo de Prenda',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context
                    .push('${AppRouter.adminTypeGarmentUpdate}/$typeGarmentId');
              } else if (value == 'delete') {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar eliminación'),
                    content: const Text(
                        '¿Estás seguro de eliminar este tipo de prenda?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                );

                if (shouldDelete == true) {
                  final provider = context.read<ActionProvider>();
                  final success =
                      await provider.deleteTypeGarment(typeGarmentId);

                  if (context.mounted) {
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Tipo de prenda eliminado correctamente')),
                      );
                      await provider.loadInitialData();
                      if (context.mounted && context.canPop()) {
                        context.pop();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Error al eliminar el tipo de prenda')),
                      );
                    }
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Editar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Eliminar', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _TypeGarmentDetailView(typeGarmentId: typeGarmentId),
    );
  }
}

class _TypeGarmentDetailView extends StatelessWidget {
  final String typeGarmentId;
  const _TypeGarmentDetailView({required this.typeGarmentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        final typeGarment = provider.typeGarments.firstWhere(
          (t) => t.id == typeGarmentId,
          orElse: () => TypeGarment(id: '', name: 'No encontrado'),
        );

        if (typeGarment.id!.isEmpty) {
          return Center(
            child: Text(
              'Tipo de prenda no encontrado',
              style: AppStyles.h3(color: AppColors.darkColor),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5,
              vertical: AppSize.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type Garment Status Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.defaultRadius),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(AppSize.defaultPadding),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              AppColors.primarySkyBlue.withOpacity(0.1),
                          child: Icon(
                            Icons.checkroom,
                            size: 30,
                            color: AppColors.primarySkyBlue,
                          ),
                        ),
                        SizedBox(width: AppSize.defaultPadding),
                        Expanded(
                          child: Text(
                            typeGarment.name,
                            style: AppStyles.h3(
                              color: AppColors.darkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSize.defaultPadding * 2),

                // Type Garment Information
                Text(
                  'Información del Tipo de Prenda',
                  style: AppStyles.h2(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                _DetailItem(
                  title: 'ID',
                  value: typeGarment.id!,
                ),
                _DetailItem(
                  title: 'Nombre',
                  value: typeGarment.name,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const _DetailItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.h3(
              color: AppColors.darkColor50,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding * 0.25),
          Text(
            value,
            style: AppStyles.h4(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
