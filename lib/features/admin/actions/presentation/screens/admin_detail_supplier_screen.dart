import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/suppliers.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminDetailSupplierScreen extends StatelessWidget {
  final String supplierId;
  const AdminDetailSupplierScreen({super.key, required this.supplierId});

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
          'Detalle del Proveedor',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                context.push('${AppRouter.adminSupplierUpdate}/$supplierId');
              } else if (value == 'delete') {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar eliminación'),
                    content:
                        const Text('¿Estás seguro de eliminar este proveedor?'),
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
                  final success = await provider.deleteSupplier(supplierId);

                  if (context.mounted) {
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Proveedor eliminado correctamente')),
                      );
                      await provider.loadInitialData();
                      context.pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al eliminar el proveedor')),
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
      body: _SupplierDetailView(supplierId: supplierId),
    );
  }
}

class _SupplierDetailView extends StatelessWidget {
  final String supplierId;
  const _SupplierDetailView({required this.supplierId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<Suppliers?>(
          future: provider.getSupplierById(supplierId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final supplier = snapshot.data;
            if (supplier == null) {
              return Center(
                child: Text(
                  'Proveedor no encontrado',
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
                    // Status Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.defaultRadius),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(AppSize.defaultPadding),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  AppColors.primarySkyBlue.withOpacity(0.1),
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.business,
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
                                    supplier.name,
                                    style: AppStyles.h3(
                                      color: AppColors.darkColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'DNI: ${supplier.dni}',
                                    style: AppStyles.h4(
                                        color: AppColors.darkColor50),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppSize.defaultPadding * 2),

                    // Basic Information
                    Text(
                      'Información Básica',
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    _DetailItem(
                      title: 'ID del Proveedor',
                      value: supplier.id ?? 'N/A',
                    ),
                    _DetailItem(
                      title: 'Descripción',
                      value: supplier.description,
                    ),

                    SizedBox(height: AppSize.defaultPadding * 2),

                    // Contact Information
                    Text(
                      'Información de Contacto',
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    _DetailItem(
                      title: 'Teléfono',
                      value: supplier.phone,
                    ),

                    SizedBox(height: AppSize.defaultPadding * 2),

                    // Bank Information
                    Text(
                      'Información Bancaria',
                      style: AppStyles.h2(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSize.defaultPadding),
                    _DetailItem(
                      title: 'Cuenta Bancaria',
                      value: supplier.bankAccount,
                    ),
                  ],
                ),
              ),
            );
          },
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
