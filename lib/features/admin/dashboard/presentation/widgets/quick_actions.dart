import 'package:flutter/material.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';

class QuickAction extends StatelessWidget {
  final String label; // El texto del botón
  final IconData icon; // El ícono que se mostrará
  final VoidCallback onTap; // La acción a ejecutar al hacer clic

  const QuickAction({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppSize.defaultPadding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 24,
            ),
          ),
          SizedBox(height: AppSize.defaultPadding * 0.3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.primarySkyBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
