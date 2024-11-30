import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tienda_comercial_chinito_app/utils/app_size.dart';

class ExpensesChart extends StatelessWidget {
  // Datos de ejemplo de egresos
  final List<double> expensesData = [
    500.0, // Enero
    450.0, // Febrero
    600.0, // Marzo
    550.0, // Abril
    700.0, // Mayo
    650.0, // Junio
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.defaultPadding),
            AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          const meses = [
                            'Ene',
                            'Feb',
                            'Mar',
                            'Abr',
                            'May',
                            'Jun'
                          ];
                          return Padding(
                            padding:
                                EdgeInsets.only(top: AppSize.defaultPadding),
                            child: Text(meses[value.toInt()]),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          return Text('\$${value.toInt()}');
                        },
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: expensesData.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
