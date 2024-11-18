import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class FilterCategories extends StatefulWidget {
  final List<String> categories; // Para recibir las categorías
  final Function(String) onCategorySelected; // Para manejar la selección

  const FilterCategories({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<FilterCategories> createState() => _FilterCategoriesState();
}

class _FilterCategoriesState extends State<FilterCategories> {
  String selectedFilter =
      ''; // Iniciamos vacío o puedes usar widget.categories[0]

  @override
  void initState() {
    super.initState();
    // Establecemos el primer elemento como seleccionado inicialmente
    if (widget.categories.isNotEmpty) {
      selectedFilter = widget.categories[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: selectedFilter == category,
              label: Text(category),
              onSelected: (bool selected) {
                setState(() {
                  selectedFilter = category;
                });
                widget.onCategorySelected(category);
              },
              backgroundColor: AppColors.primaryGrey,
              selectedColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: selectedFilter == category
                    ? AppColors.primaryGrey
                    : AppColors.primaryColor,
              ),
              shape: const StadiumBorder(
                side: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
