import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class QuickStatsRow extends StatelessWidget {
  final int products;
  final int lowStock;
  final int highStocK;

  const QuickStatsRow({
    super.key,
    required this.products,
    required this.lowStock,
    required this.highStocK,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _StatCard(
            title: 'Productos',
            value: products.toString(),
            icon: Icons.auto_graph,
          ),
        ),
        Expanded(
          child: _StatCard(
            title: 'P. Stock Bajo',
            value: lowStock.toString(),
            icon: Icons.call_received,
          ),
        ),
        Expanded(
          child: _StatCard(
            title: 'P. Sin Stock',
            value: highStocK.toString(),
            icon: Icons.import_export,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.primarySkyBlue,
      child: Padding(
        //padding de arriba y abajo
        padding: EdgeInsets.symmetric(
          vertical: AppSize.defaultPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            Text(
              value,
              style: AppStyles.h2(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              title,
              style: AppStyles.h5(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
