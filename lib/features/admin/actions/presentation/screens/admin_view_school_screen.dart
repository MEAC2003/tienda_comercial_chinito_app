import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/core/config/app_router.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/zones.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class AdminViewSchoolScreen extends StatefulWidget {
  const AdminViewSchoolScreen({super.key});

  @override
  State<AdminViewSchoolScreen> createState() => _AdminViewSchoolScreenState();
}

class _AdminViewSchoolScreenState extends State<AdminViewSchoolScreen> {
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
          'Colegios',
          style: AppStyles.h3p5(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRouter.adminAddSchool),
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
                        context.read<ActionProvider>().searchSchools(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar colegios...',
                        hintStyle: AppStyles.h4(color: AppColors.darkColor50),
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSize.defaultPadding * 2),

                  // Schools Grid
                  Consumer<ActionProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final schools = provider.filteredSchools;

                      if (schools.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.school_outlined,
                                size: 64,
                                color: AppColors.darkColor50,
                              ),
                              SizedBox(height: AppSize.defaultPadding),
                              Text(
                                'No hay colegios disponibles',
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
                          childAspectRatio: 0.85,
                        ),
                        itemCount: schools.length,
                        itemBuilder: (context, index) {
                          final school = schools[index];
                          final zone = provider.zones.firstWhere(
                            (z) => z.id == school.zoneId,
                            orElse: () => Zones(id: '', name: 'Sin zona'),
                          );

                          return Card(
                            child: InkWell(
                              onTap: () {
                                context.push(
                                    '${AppRouter.adminDetailSchool}/${school.id}');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.school,
                                      size: 48,
                                      color: AppColors.primarySkyBlue,
                                    ),
                                    SizedBox(height: AppSize.defaultPadding),
                                    Text(
                                      school.name,
                                      style: AppStyles.h4(
                                        color: AppColors.darkColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                        height: AppSize.defaultPadding * 0.5),
                                    Text(
                                      'Descripción: ${school.level}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: AppStyles.h5(
                                        color: AppColors.darkColor50,
                                      ),
                                    ),
                                    Text(
                                      'Zona: ${zone.name}',
                                      style: AppStyles.h5(
                                        color: AppColors.darkColor50,
                                      ),
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
