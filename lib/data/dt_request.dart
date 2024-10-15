import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/md_request.dart';

List<RequestPlant> REQUEST_ROWS_DATA = [];

// ----------------------------------------------------------------------------
// REQUEST TABLE

const String col_plantID = 'Request ID';
const String col_userID = 'User ID';
const String col_plantName = 'Plant Name';
const String col_scientific = 'Scientific Name';
const String col_description = 'Description';
const String col_plantPicture = 'Picture';
const String col_handleBy = 'Handle By';
const String col_plantStatus = 'Status';
const String col_plantRequestDate = 'Request Date';
const String col_plantLastUpdated = 'Last Updated';

List<GridColumn> requestColumns() {
  List<String> columns = [
    col_plantID,
    col_userID,
    col_plantName,
    col_scientific,
    col_description,
    col_plantPicture,
    col_handleBy,
    col_plantStatus,
    col_plantRequestDate,
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

List<DataGridRow> requestRows(List<RequestPlant> requests) {
  return requests
      .map((RequestPlant request) => DataGridRow(cells: [
            DataGridCell<int>(
              columnName: col_plantID,
              value: request.id,
            ),
            DataGridCell<int>(
              columnName: col_userID,
              value: request.user_id,
            ),
            DataGridCell<String>(
              columnName: col_plantName,
              value: request.plant_name,
            ),
            DataGridCell<String>(
              columnName: col_scientific,
              value: request.scientific_name,
            ),
            DataGridCell<String>(
              columnName: col_description,
              value: request.description,
            ),
            DataGridCell<String>(
              columnName: col_plantPicture,
              value: request.image_url,
            ),
            DataGridCell<dynamic>(
              columnName: col_handleBy,
              value: request.handle_by,
            ),
            DataGridCell<String>(
              columnName: col_plantStatus,
              value: request.status,
            ),
            DataGridCell<String>(
              columnName: col_plantRequestDate,
              value: request.date_created,
            ),
            DataGridCell<String>(
              columnName: col_plantLastUpdated,
              value: request.last_updated,
            ),
          ]))
      .toList();
}

// ----------------------------------------------------------------------------
// REQUEST DATA SOURCE
class RequestDataSource extends DataGridSource {
  RequestDataSource(List<RequestPlant> rows) {
    data = rows;
  }

  late var data;
  @override
  List<DataGridRow> get rows => requestRows(data);

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
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
      case col_plantRequestDate:
      case col_plantLastUpdated:
        return Text(value, overflow: TextOverflow.ellipsis);
      case col_plantPicture:
        // return Image.asset(value);
        return Text(value);
      default:
        return Text(value);
    }
  }
}
