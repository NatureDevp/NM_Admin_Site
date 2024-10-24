import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/md_plant.dart';

List<Plants> PLANT_ROWS_DATA = [];

// ----------------------------------------------------------------------------
// REQUEST TABLE

const String col_plantID = 'Plant ID';
const String col_plantName = 'Plant Name';
const String col_plantScientificName = 'Scientific Name';
const String col_plantPicture = 'Picture';
const String col_plantStatus = 'Status';
const String col_plantLikes = 'Likes';
const String col_plantCreatedDate = 'Date Created';
const String col_plantLastUpdated = 'Last Updated';

List<GridColumn> plantColumns() {
  List<String> columns = [
    col_plantID,
    col_plantName,
    col_plantScientificName,
    col_plantPicture,
    col_plantStatus,
    col_plantLikes,
    col_plantCreatedDate,
    col_plantLastUpdated
  ];

  return columns
      .map((columnName) => GridColumn(
            columnName: columnName,
            label: _header_Style(columnName),
          ))
      .toList();
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

List<DataGridRow> plantRows(List<Plants> plants) {
  return plants
      .map((Plants plant) => DataGridRow(cells: [
            DataGridCell<int>(
              columnName: col_plantID,
              value: plant.id,
            ),
            DataGridCell<String>(
              columnName: col_plantName,
              value: plant.name,
            ),
            DataGridCell<String>(
              columnName: col_plantScientificName,
              value: plant.scientific_name,
            ),
            DataGridCell<String>(
              columnName: col_plantPicture,
              value: plant.cover,
            ),
            DataGridCell<String>(
              columnName: col_plantStatus,
              value: plant.status,
            ),
            DataGridCell<int>(
              columnName: col_plantLikes,
              value: plant.likes,
            ),
            DataGridCell<String>(
              columnName: col_plantCreatedDate,
              value: plant.date_created,
            ),
            DataGridCell<String>(
              columnName: col_plantLastUpdated,
              value: plant.last_updated,
            )
          ]))
      .toList();
}

// ----------------------------------------------------------------------------
// PLANT DATA SOURCE
class PlantDataSource extends DataGridSource {
  PlantDataSource(List<Plants> rows) {
    data = rows;
  }

  late var data;
  @override
  List<DataGridRow> get rows => plantRows(data);

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: widgetType(cell.value.toString(), cell.columnName),
        );
      }).toList(),
    );
  }

  Widget widgetType(String value, String columnName) {
    switch (columnName) {
      case col_plantID:
      case col_plantName:
      case col_plantStatus:
      case col_plantLikes:
      case col_plantCreatedDate:
      case col_plantLastUpdated:
        return Text(value,
            overflow: TextOverflow.ellipsis, textAlign: TextAlign.left);
      case col_plantPicture:
        // return Image.asset(value);
        return Text(value,
            overflow: TextOverflow.ellipsis, textAlign: TextAlign.left);
      default:
        return Text(value, textAlign: TextAlign.left);
    }
  }
}
