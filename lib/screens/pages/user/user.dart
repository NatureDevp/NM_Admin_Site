import 'package:admin_side/controllers/sidebar.dart';
import 'package:admin_side/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // For navigation

import '../../../data/user.dart';
import 'user_info.dart'; // Import the user information page
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: UserDataTable(),
    );
  }
}

class UserDataTable extends StatelessWidget {
  UserDataTable({super.key}) : _dataGridSource = _CustomDataGridSource();

  late final _CustomDataGridSource _dataGridSource;

  @override
  Widget build(BuildContext context) {
    SidebarController sidebarController = Get.find<SidebarController>();
    return SfDataGrid(
      source: _dataGridSource,
      columnWidthMode: ColumnWidthMode.fill,
      onCellTap: (details) {
        if (details.rowColumnIndex.rowIndex != 0) {
          int selectedIndex = details.rowColumnIndex.rowIndex - 1;
          User selectedUser = _dataGridSource.userData[selectedIndex];

          sidebarController.selectButton(7, args: selectedUser);
        }
      },
      columns: [
        GridColumn(
          columnName: USER_COLUMNS.id,
          label: _header_Style(USER_COLUMNS.id),
        ),
        GridColumn(
          columnName: USER_COLUMNS.name,
          label: _header_Style(USER_COLUMNS.name),
        ),
        GridColumn(
          columnName: USER_COLUMNS.email,
          label: _header_Style(USER_COLUMNS.email),
        ),
        GridColumn(
          columnName: USER_COLUMNS.dateCreated,
          label: _header_Style(USER_COLUMNS.dateCreated),
        ),
        GridColumn(
          columnName: USER_COLUMNS.lastUpdated,
          label: _header_Style(USER_COLUMNS.lastUpdated),
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
  List<User> userData = ALL_USERS; // Replace with real user data
  List<DataGridRow> _dataGridRows = [];

  _CustomDataGridSource() {
    _dataGridRows = List.generate(
      userData.length,
      (index) => DataGridRow(cells: [
        DataGridCell<String>(
          columnName: USER_COLUMNS.id,
          value: userData[index].id,
        ),
        DataGridCell<String>(
          columnName: USER_COLUMNS.name,
          value: userData[index].name,
        ),
        DataGridCell<String>(
          columnName: USER_COLUMNS.email,
          value: userData[index].email,
        ),
        DataGridCell<String>(
          columnName: USER_COLUMNS.dateCreated,
          value: userData[index].dateCreated,
        ),
        DataGridCell<String>(
          columnName: USER_COLUMNS.lastUpdated,
          value: userData[index].lastUpdated,
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
      child: Text(
        cell.value.toString(),
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
