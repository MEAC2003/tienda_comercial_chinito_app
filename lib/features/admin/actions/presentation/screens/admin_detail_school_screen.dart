import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/schools.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminDetailSchoolScreen extends StatelessWidget {
  final String schoolId;
  const AdminDetailSchoolScreen({super.key, required this.schoolId});

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
          'Detalle del Colegio',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context.push('${AppRouter.adminSchoolUpdate}/$schoolId');
              } else if (value == 'delete') {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar eliminación'),
                    content:
                        const Text('¿Estás seguro de eliminar este colegio?'),
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
                  final success = await provider.deleteSchool(schoolId);

                  if (context.mounted) {
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Colegio eliminado correctamente')),
                      );
                      await provider.loadInitialData();
                      if (context.mounted && context.canPop()) {
                        context.pop();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al eliminar el colegio')),
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
      body: _SchoolDetailView(schoolId: schoolId),
    );
  }
}

class _SchoolDetailView extends StatelessWidget {
  final String schoolId;
  const _SchoolDetailView({required this.schoolId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        final school = provider.schools.firstWhere(
          (s) => s.id == schoolId,
          orElse: () =>
              Schools(id: '', name: 'No encontrado', level: '', zoneId: ''),
        );

        if (school.id!.isEmpty) {
          return Center(
            child: Text(
              'Colegio no encontrado',
              style: AppStyles.h3(color: AppColors.darkColor),
            ),
          );
        }

        final zone = provider.zones.firstWhere(
          (z) => z.id == school.zoneId,
          orElse: () => Zones(id: '', name: 'Sin zona'),
        );

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.defaultPaddingHorizontal * 1.5,
              vertical: AppSize.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // School Status Card
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
                            Icons.school,
                            size: 30,
                            color: AppColors.primarySkyBlue,
                          ),
                        ),
                        SizedBox(width: AppSize.defaultPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                school.name,
                                style: AppStyles.h3(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Nivel: ${school.level}',
                                style:
                                    AppStyles.h4(color: AppColors.darkColor50),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSize.defaultPadding * 2),

                // School Information
                Text(
                  'Información del Colegio',
                  style: AppStyles.h2(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                _DetailItem(
                  title: 'ID',
                  value: school.id!,
                ),
                _DetailItem(
                  title: 'Nombre',
                  value: school.name,
                ),
                _DetailItem(
                  title: 'Nivel',
                  value: school.level,
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
                  title: 'ID de Zona',
                  value: zone.id!,
                ),
                _DetailItem(
                  title: 'Nombre de Zona',
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
