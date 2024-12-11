import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminViewSizeScreen extends StatefulWidget {
  const AdminViewSizeScreen({super.key});

  @override
  State<AdminViewSizeScreen> createState() => _AdminViewSizeScreenState();
}

class _AdminViewSizeScreenState extends State<AdminViewSizeScreen> {
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
          'Tallas',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRouter.adminAddSize),
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
                        context.read<ActionProvider>().searchSizes(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar tallas...',
                        hintStyle: AppStyles.h4(color: AppColors.darkColor50),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSize.defaultPadding * 2),

                  // Sizes Grid
                  Consumer<ActionProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final sizes = provider.filteredSizes;

                      if (sizes.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.straighten_outlined,
                                size: 64,
                                color: AppColors.darkColor50,
                              ),
                              SizedBox(height: AppSize.defaultPadding),
                              Text(
                                'No hay tallas disponibles',
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
                        itemCount: sizes.length,
                        itemBuilder: (context, index) {
                          final size = sizes[index];
                          return Card(
                            child: InkWell(
                              onTap: () {
                                context.push(
                                    '${AppRouter.adminDetailSize}/${size.id}');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.straighten,
                                      size: 48,
                                      color: AppColors.primarySkyBlue,
                                    ),
                                    SizedBox(height: AppSize.defaultPadding),
                                    Text(
                                      size.name,
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
