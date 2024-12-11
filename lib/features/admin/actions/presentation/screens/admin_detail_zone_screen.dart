import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminDetailZoneScreen extends StatelessWidget {
  final String zoneId;
  const AdminDetailZoneScreen({super.key, required this.zoneId});

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
          'Detalle de Zona',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context.push('${AppRouter.adminZoneUpdate}/$zoneId');
              } else if (value == 'delete') {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar eliminación'),
                    content: const Text('¿Estás seguro de eliminar esta zona?'),
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
                  final success = await provider.deleteZone(zoneId);

                  if (context.mounted) {
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Zona eliminada correctamente')),
                      );
                      await provider.loadInitialData();
                      if (context.mounted && context.canPop()) {
                        context.pop();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al eliminar la zona')),
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
      body: _ZoneDetailView(zoneId: zoneId),
    );
  }
}

class _ZoneDetailView extends StatelessWidget {
  final String zoneId;
  const _ZoneDetailView({required this.zoneId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        final zone = provider.zones.firstWhere(
          (z) => z.id == zoneId,
          orElse: () => Zones(id: '', name: 'No encontrada'),
        );

        if (zone.id!.isEmpty) {
          return Center(
            child: Text(
              'Zona no encontrada',
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
                // Zone Status Card
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
                            Icons.place,
                            size: 30,
                            color: AppColors.primarySkyBlue,
                          ),
                        ),
                        SizedBox(width: AppSize.defaultPadding),
                        Expanded(
                          child: Text(
                            zone.name,
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

                // Zone Information
                Text(
                  'Información de la Zona',
                  style: AppStyles.h2(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                _DetailItem(
                  title: 'ID',
                  value: zone.id ?? '',
                ),
                _DetailItem(
                  title: 'Nombre',
                  value: zone.name,
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
