import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminDetailSizeScreen extends StatelessWidget {
  final String sizeId;
  const AdminDetailSizeScreen({super.key, required this.sizeId});

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
          'Detalle de Talla',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context.push('${AppRouter.adminSizeUpdate}/$sizeId');
              } else if (value == 'delete') {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar eliminación'),
                    content:
                        const Text('¿Estás seguro de eliminar esta talla?'),
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
                  final success = await provider.deleteSize(sizeId);

                  if (context.mounted) {
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Talla eliminada correctamente')),
                      );
                      await provider.loadInitialData();
                      if (context.mounted && context.canPop()) {
                        context.pop();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al eliminar la talla')),
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
      body: _SizeDetailView(sizeId: sizeId),
    );
  }
}

class _SizeDetailView extends StatelessWidget {
  final String sizeId;
  const _SizeDetailView({required this.sizeId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        final size = provider.sizes.firstWhere(
          (s) => s.id.toString() == sizeId,
          orElse: () => Sizes(id: 0, name: 'No encontrada'),
        );

        if (size.id == 0) {
          return Center(
            child: Text(
              'Talla no encontrada',
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
                // Size Status Card
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
                            Icons.straighten,
                            size: 30,
                            color: AppColors.primarySkyBlue,
                          ),
                        ),
                        SizedBox(width: AppSize.defaultPadding),
                        Expanded(
                          child: Text(
                            size.name,
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

                // Size Information
                Text(
                  'Información de la Talla',
                  style: AppStyles.h2(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                _DetailItem(
                  title: 'ID',
                  value: size.id.toString(),
                ),
                _DetailItem(
                  title: 'Nombre',
                  value: size.name,
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
