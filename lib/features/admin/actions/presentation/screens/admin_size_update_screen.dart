import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/sizes.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/features/shared/shared.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminSizeUpdateScreen extends StatefulWidget {
  final String sizeId;
  const AdminSizeUpdateScreen({super.key, required this.sizeId});

  @override
  State<AdminSizeUpdateScreen> createState() => _AdminSizeUpdateScreenState();
}

class _AdminSizeUpdateScreenState extends State<AdminSizeUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Sizes? _size;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ActionProvider>();
      final size = provider.sizes.firstWhere(
        (s) => s.id.toString() == widget.sizeId,
        orElse: () => Sizes(id: 0, name: ''),
      );

      setState(() {
        _size = size;
        _nameController.text = size.name;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateSize() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final provider = context.read<ActionProvider>();
      final success = await provider.updateSize(
        id: widget.sizeId,
        name: _nameController.text,
      );

      if (!mounted) return;

      if (success) {
        await provider.loadInitialData();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Talla actualizada exitosamente')),
        );
        if (context.canPop()) {
          context.pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar la talla')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la talla: $e')),
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
          'Actualizar Talla',
          style: AppStyles.h2(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _size == null
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
                        'ID de la Talla',
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
                          widget.sizeId,
                          style: AppStyles.h4(color: AppColors.darkColor),
                        ),
                      ),
                      SizedBox(height: AppSize.defaultPadding * 2),
                      CustomTextFields(
                        label: 'Nombre de la Talla',
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
                        text: 'Actualizar Talla',
                        onPressed: _updateSize,
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
