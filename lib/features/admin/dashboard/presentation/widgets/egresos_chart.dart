import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:tienda_comercial_chinito_app/utils/utils.dart';
import 'package:tienda_comercial_chinito_app/features/admin/dashboard/presentation/providers/dashboard_provider.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({super.key});

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  @override
  void initState() {
    super.initState();
    // Load expenses data when widget initializes
    Future.microtask(
        () => context.read<DashboardProvider>().loadInventoryMovements());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        List<String> getLastSixMonths() {
          final now = DateTime.now();
          final months = [
            'Ene',
            'Feb',
            'Mar',
            'Abr',
            'May',
            'Jun',
            'Jul',
            'Ago',
            'Sep',
            'Oct',
            'Nov',
            'Dic'
          ];
          List<String> lastSixMonths = [];

          for (int i = 5; i >= 0; i--) {
            final monthIndex = (now.month - 1 - i + 12) %
                12; // Add 12 to handle negative values
            lastSixMonths.add(months[monthIndex]);
          }

          return lastSixMonths;
        }

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.defaultRadius),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movimientos del Inventario',
                  style: AppStyles.h4(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkColor,
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                AspectRatio(
                  aspectRatio: 1.7,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 100,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColors.darkColor.withOpacity(0.1),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              final meses = getLastSixMonths();
                              if (value >= 0 && value < meses.length) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: AppSize.defaultPadding),
                                  child: Text(
                                    meses[value.toInt()],
                                    style: AppStyles.h5(
                                        color: AppColors.darkColor),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                'S/ ${value.toInt()}',
                                style: AppStyles.h5(color: AppColors.darkColor),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: provider
                              .getMonthlyExpenses()
                              .asMap()
                              .entries
                              .map((entry) {
                            return FlSpot(entry.key.toDouble(), entry.value);
                          }).toList(),
                          isCurved: true,
                          color: AppColors.primarySkyBlue,
                          barWidth: 3,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: AppColors.primarySkyBlue,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.primarySkyBlue.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
