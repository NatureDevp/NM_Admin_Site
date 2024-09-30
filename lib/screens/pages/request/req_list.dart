import 'package:admin_side/controllers/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../controllers/request.dart';
import '../../../data/request.dart';
import '../../../models/request.dart';
import '../../../routes/pages.dart';
import '../../../utils/_system.dart';
import '../../../widgets/datagrid.dart';
import '../../../widgets/header.dart';
import '../../../widgets/navigation.dart';

class RequestListPage extends StatelessWidget {
  const RequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    SidebarController controller = Get.find<SidebarController>();
    //
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 0,
            child: TopNavigation(
              label: 'Workplace',
              back: () {
                controller.selectButton(1);
              },
              goTo: () {
                 controller.selectButton(5);
              },
            ),
          ),
          const Gap(5),
          Divider(
            color: SystemColor.mediumGrey,
            thickness: 0.1,
          ),
          const Gap(5),
          Expanded(child: RequestGridTable()),
        ],
      ),
    );
  }
}



///
///


class RequestGridTable extends StatelessWidget {
  RequestGridTable({super.key}) : _dataGridSource = _CustomDataGridSource();

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
