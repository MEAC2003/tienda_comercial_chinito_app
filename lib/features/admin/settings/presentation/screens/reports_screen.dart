import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/data/models/inventory_movements.dart';
import 'package:tienda_comercial_chinito_app/features/admin/actions/presentation/providers/action_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  int? _selectedMovementType;
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ActionProvider>(context, listen: false).loadMovements();
    });
  }

  void _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      Provider.of<ActionProvider>(context, listen: false)
          .filterByDateRange(_startDate!, _endDate!);
    }
  }

  Future<void> _exportToExcel(List<InventoryMovements> movements) async {
    setState(() => _isExporting = true);

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Generando reporte Excel...'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

      var excel = Excel.createExcel();
      var sheet = excel['Movimientos'];

      // Estilos
      var headerStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
      );

      var dataStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Left,
      );

      // Configurar anchos de columna
      sheet.setColumnWidth(0, 15); // ID
      sheet.setColumnWidth(1, 30); // Producto
      sheet.setColumnWidth(2, 20); // Tipo
      sheet.setColumnWidth(3, 15); // Cantidad
      sheet.setColumnWidth(4, 25); // Fecha
      sheet.setColumnWidth(5, 30); // Usuario

      // Encabezados
      var headers = [
        'ID',
        'Producto',
        'Tipo de Movimiento',
        'Cantidad',
        'Fecha',
        'Usuario'
      ];

      for (var i = 0; i < headers.length; i++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          ..value = TextCellValue(headers[i])
          ..cellStyle = headerStyle;
      }

      // Datos
      var rowIndex = 1;
      for (var movement in movements) {
        final product =
            await Provider.of<ActionProvider>(context, listen: false)
                .getProductById(movement.productId);
        final user = Provider.of<ActionProvider>(context, listen: false)
            .getUserById(movement.userId);

        final formattedDate = DateFormat('dd/MM/yyyy HH:mm')
            .format(DateTime.parse(movement.createdAt));

        var rowData = [
          movement.id ?? '',
          product?.name ?? 'N/A',
          movement.movementTypeId == 1 ? 'Ingreso' : 'Salida',
          movement.quantity.toString(),
          formattedDate,
          user?.fullName ?? 'N/A'
        ];

        for (var i = 0; i < rowData.length; i++) {
          sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: i, rowIndex: rowIndex))
            ..value = TextCellValue(rowData[i])
            ..cellStyle = dataStyle;
        }
        rowIndex++;
      }

      // Generar nombre de archivo con timestamp
      final now = DateTime.now();
      final timestamp =
          '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';

      final directory = await getExternalStorageDirectory();
      final path = '${directory?.path}/reporte_movimientos_$timestamp.xlsx';

      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.save()!);

      Navigator.pop(context); // Cerrar diálogo de carga

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reporte guardado en: $path'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al generar el reporte: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() => _isExporting = false);
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar por Tipo de Movimiento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<int>(
              title: const Text('Ingreso'),
              value: 1,
              groupValue: _selectedMovementType,
              onChanged: (value) {
                setState(() => _selectedMovementType = value);
                Provider.of<ActionProvider>(context, listen: false)
                    .filterByType(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<int>(
              title: const Text('Salida'),
              value: 2,
              groupValue: _selectedMovementType,
              onChanged: (value) {
                setState(() => _selectedMovementType = value);
                Provider.of<ActionProvider>(context, listen: false)
                    .filterByType(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _selectedMovementType = null);
              Provider.of<ActionProvider>(context, listen: false)
                  .resetFilters();
              Navigator.pop(context);
            },
            child: const Text('Limpiar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes de Inventario'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDateRange(context),
            tooltip: 'Seleccionar rango de fechas',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filtrar por tipo',
          ),
        ],
      ),
      body: Consumer<ActionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando movimientos...'),
                ],
              ),
            );
          }

          final movements = provider.movements;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_startDate != null && _endDate != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),
                          const SizedBox(width: 8),
                          Text(
                            'Rango: ${DateFormat('dd/MM/yyyy').format(_startDate!)} - ${DateFormat('dd/MM/yyyy').format(_endDate!)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _isExporting || movements.isEmpty
                      ? null
                      : () => _exportToExcel(movements),
                  icon: const Icon(Icons.download),
                  label:
                      Text(_isExporting ? 'Exportando...' : 'Exportar Excel'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Card(
                    child: movements.isEmpty
                        ? const Center(
                            child: Text('No hay movimientos para mostrar'),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: movements.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final movement = movements[index];
                              return ListTile(
                                leading: Icon(
                                  movement.movementTypeId == 1
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color: movement.movementTypeId == 1
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                title: Text(
                                  'Movimiento ${movement.id}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  'Fecha: ${provider.formatDate(movement.createdAt)}\n'
                                  'Tipo: ${movement.movementTypeId == 1 ? 'Ingreso' : 'Salida'}',
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<ActionProvider>(context, listen: false).resetFilters(),
        child: const Icon(Icons.refresh),
        tooltip: 'Resetear filtros',
      ),
    );
  }
}
