import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminViewTypeGarmentScreen extends StatefulWidget {
  const AdminViewTypeGarmentScreen({super.key});

  @override
  State<AdminViewTypeGarmentScreen> createState() =>
      _AdminViewTypeGarmentScreenState();
}

class _AdminViewTypeGarmentScreenState
    extends State<AdminViewTypeGarmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActionProvider>().loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Tipos de Prenda',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRouter.adminAddTypeGarment),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ActionProvider>().loadInitialData(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search TextField
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 240, 243, 243),
                          Color.fromARGB(255, 243, 241, 241),
                          Color.fromARGB(255, 231, 231, 231),
                        ],
                        stops: [0.03, 0.12, 1.0],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppSize.defaultRadius),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<ActionProvider>()
                            .searchTypeGarments(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar tipos de prenda...',
                        hintStyle: AppStyles.h4(color: AppColors.darkColor50),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSize.defaultPadding * 2),

                  // Type Garments Grid
                  Consumer<ActionProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final typeGarments = provider.filteredTypeGarments;

                      if (typeGarments.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.checkroom_outlined,
                                size: 64,
                                color: AppColors.darkColor50,
                              ),
                              SizedBox(height: AppSize.defaultPadding),
                              Text(
                                'No hay tipos de prenda disponibles',
                                style: AppStyles.h4(color: AppColors.darkColor),
                              ),
                            ],
                          ),
                        );
                      }

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: typeGarments.length,
                        itemBuilder: (context, index) {
                          final typeGarment = typeGarments[index];
                          return Card(
                            child: InkWell(
                              onTap: () {
                                context.push(
                                    '${AppRouter.adminDetailTypeGarment}/${typeGarment.id}');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.checkroom,
                                      size: 48,
                                      color: AppColors.primarySkyBlue,
                                    ),
                                    SizedBox(height: AppSize.defaultPadding),
                                    Text(
                                      typeGarment.name,
                                      style: AppStyles.h4(
                                        color: AppColors.darkColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
