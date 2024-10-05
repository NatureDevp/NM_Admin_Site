// Import the PlantInfo page
import 'package:admin_side/screens/pages/plant/plant_info.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../data/plants.dart';
import '../../../data/request.dart';
import '../../../models/plant.dart';
import '../../../models/request.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 11, 170, 17),
            elevation: 5,
          ),
          onPressed: () {
            // Add your action here
          },
          child: Text('Add Plant'),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: PlantDataTable(),
          ),
        ),
      ],
    );
  }
}

class PlantDataTable extends StatelessWidget {
  PlantDataTable({super.key}) : _dataGridSource = _CustomDataGridSource();

  late final _CustomDataGridSource _dataGridSource;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      checkboxShape: const BeveledRectangleBorder(),
      source: _dataGridSource,
      allowSorting: true,
      columnWidthMode: ColumnWidthMode.fill,
      onCellTap: (details) {
        if (details.rowColumnIndex.rowIndex > 0) {
          final selectedPlant =
              _dataGridSource.plantData[details.rowColumnIndex.rowIndex - 1];
          // Navigate to the PlantInfo page with plant details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlantInfo(
                plantName: selectedPlant.name,
                scientificName: selectedPlant.scientificName,
                description: selectedPlant.description,
                imageUrl: selectedPlant.imageUrl,
              ),
            ),
          );
        }
      },
      columns: [
        GridColumn(
          columnName: PLANT_COLUMN.id,
          label: _header_Style(PLANT_COLUMN.id),
        ),
        GridColumn(
          columnName: PLANT_COLUMN.name,
          label: _header_Style(PLANT_COLUMN.name),
        ),
        GridColumn(
          columnName: PLANT_COLUMN.imageUrl,
          label: _header_Style(PLANT_COLUMN.imageUrl),
        ),
        GridColumn(
          columnName: PLANT_COLUMN.dateCreated,
          label: _header_Style(PLANT_COLUMN.dateCreated),
        ),
        GridColumn(
          columnName: PLANT_COLUMN.status,
          label: _header_Style(PLANT_COLUMN.status),
        ),
        GridColumn(
          columnName: PLANT_COLUMN.lastUpdated,
          label: _header_Style(PLANT_COLUMN.lastUpdated),
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
  List<Plants> plantData = ALL_PLANTS;
  List<DataGridRow> _dataGridRows = [];

  _CustomDataGridSource() {
    _dataGridRows = List.generate(
      plantData.length,
      (index) => DataGridRow(cells: [
        DataGridCell<String>(
          columnName: PLANT_COLUMN.id,
          value: plantData[index].id.toString(),
        ),
        DataGridCell<String>(
          columnName: PLANT_COLUMN.name,
          value: plantData[index].name,
        ),
        DataGridCell<String>(
          columnName: PLANT_COLUMN.imageUrl,
          value: plantData[index].imageUrl,
        ),
        DataGridCell<String>(
          columnName: PLANT_COLUMN.dateCreated,
          value: plantData[index].dateCreated,
        ),
        DataGridCell<String>(
          columnName: PLANT_COLUMN.status,
          value: plantData[index].status,
        ),
        DataGridCell<String>(
          columnName: PLANT_COLUMN.lastUpdated,
          value: plantData[index].lastUpdated,
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

  Widget _row_Style(DataGridCell cell) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: (cell.columnName == PLANT_COLUMN.imageUrl)
          ? Text(
              cell.value.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal),
            )
          : Text(
              cell.value.toString(),
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
    );
  }
}
