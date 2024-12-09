import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class FilterCategories extends StatefulWidget {
  final String initialCategory;
  final List<String> categories;
  final Function(String) onCategorySelected;

  const FilterCategories({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    required this.initialCategory,
  });

  @override
  State<FilterCategories> createState() => _FilterCategoriesState();
}

class _FilterCategoriesState extends State<FilterCategories> {
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialCategory;
  }

  @override
  void didUpdateWidget(covariant FilterCategories oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategory != widget.initialCategory) {
      setState(() {
        selectedFilter = widget.initialCategory;
      });
    }
  }

  void _selectCategory(String category) {
    setState(() {
      selectedFilter = category;
    });
    widget.onCategorySelected(category);
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
              label: Text(
                category.contains('I.E')
                    ? category
                    : category
                        .split(' ')
                        .map((word) =>
                            word[0].toUpperCase() +
                            word.substring(1).toLowerCase())
                        .join(' '),
              ),
              onSelected: (_) => _selectCategory(category),
              backgroundColor: AppColors.primaryGrey,
              selectedColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: selectedFilter == category
                    ? AppColors.primaryGrey
                    : AppColors.primaryColor,
                fontWeight: selectedFilter == category
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selectedFilter == category
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.5),
                  width: selectedFilter == category ? 2.0 : 1.0,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
