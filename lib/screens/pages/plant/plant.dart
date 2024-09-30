import 'package:admin_side/screens/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../data/request.dart';
import '../../../models/request.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: PlantDataTable(),
    );
  }
}




class PlantDataTable extends StatelessWidget {
  PlantDataTable({super.key}) : _dataGridSource = _CustomDataGridSource();

  late final _CustomDataGridSource _dataGridSource;

  @override
  Widget build(BuildContext context) {
    //
    return SfDataGrid(
      checkboxShape: const BeveledRectangleBorder(),
      source: _dataGridSource,
      allowSorting: true,
      columnWidthMode: ColumnWidthMode.fill,
      columns: [
        GridColumn(
          columnName: REQUEST_COLUMNS.id,
          label: _header_Style(REQUEST_COLUMNS.id),
        ),
        GridColumn(
          columnName: REQUEST_COLUMNS.plant,
          label: _header_Style(REQUEST_COLUMNS.plant),
        ),
        GridColumn(
          columnName: REQUEST_COLUMNS.imageUrl,
          label: _header_Style(REQUEST_COLUMNS.imageUrl),
        ),
        GridColumn(
          columnName: REQUEST_COLUMNS.requestDate,
          label: _header_Style(REQUEST_COLUMNS.requestDate),
        ),
        GridColumn(
          columnName: REQUEST_COLUMNS.status,
          label: _header_Style(REQUEST_COLUMNS.status),
        ),
        GridColumn(
          columnName: REQUEST_COLUMNS.lastUpdated,
          label: _header_Style(REQUEST_COLUMNS.lastUpdated),
        ),
      ],
    );
  }

  Widget _header_Style(String label) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CustomDataGridSource extends DataGridSource {
  List<Request> requestData = REQUESTS;
  List<DataGridRow> _dataGridRows = [];

  _CustomDataGridSource() {
    //
    _dataGridRows = List.generate(
      requestData.length,
      (index) => DataGridRow(cells: [
        DataGridCell<String>(
          columnName: REQUEST_COLUMNS.id,
          value: requestData[index].id,
        ),
        DataGridCell<String>(
          columnName: REQUEST_COLUMNS.plant,
          value: requestData[index].plant,
        ),
        DataGridCell<String>(
          columnName: REQUEST_COLUMNS.imageUrl,
          value: requestData[index].imageUrl,
        ),
        DataGridCell<String>(
          columnName: REQUEST_COLUMNS.requestDate,
          value: requestData[index].requestDate,
        ),
        DataGridCell<String>(
          columnName: REQUEST_COLUMNS.status,
          value: requestData[index].status,
        ),
        DataGridCell<String>(
          columnName: REQUEST_COLUMNS.lastUpdated,
          value: requestData[index].lastUpdated,
        ),
      ]),
    );
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    var cells = row.getCells();
    return DataGridRowAdapter(
      cells: cells.map((cell) => _row_Style(cell)).toList(),
    );
  }

  Widget _row_Style(cell) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: (cell.columnName == REQUEST_COLUMNS.imageUrl)
          ? Image.asset(
              cell.value.toString(),
            )
          : Text(
              cell.value.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
    );
  }
}
