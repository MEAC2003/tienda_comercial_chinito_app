import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminZoneUpdateScreen extends StatefulWidget {
  final String zoneId;
  const AdminZoneUpdateScreen({super.key, required this.zoneId});

  @override
  State<AdminZoneUpdateScreen> createState() => _AdminZoneUpdateScreenState();
}

class _AdminZoneUpdateScreenState extends State<AdminZoneUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Zones? _zone;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ActionProvider>();
      final zone = provider.zones.firstWhere(
        (z) => z.id == widget.zoneId,
        orElse: () => Zones(id: '', name: ''),
      );

      setState(() {
        _zone = zone;
        _nameController.text = zone.name;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateZone() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<ActionProvider>();
      final success = await provider.updateZone(
        id: widget.zoneId,
        name: _nameController.text,
      );

      if (!mounted) return;

      if (success) {
        await provider.loadInitialData();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Zona actualizada exitosamente')),
        );
        if (context.canPop()) {
          context.pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar la zona')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la zona: $e')),
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
          'Actualizar Zona',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _zone == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(AppSize.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID de la Zona',
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
                          widget.zoneId,
                          style: AppStyles.h4(color: AppColors.darkColor),
                        ),
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomTextFields(
                        label: 'Nombre de la Zona',
                        controller: _nameController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor ingrese un nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomActionButton(
                        text: 'Actualizar Zona',
                        onPressed: _updateZone,
                        color: AppColors.primarySkyBlue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
