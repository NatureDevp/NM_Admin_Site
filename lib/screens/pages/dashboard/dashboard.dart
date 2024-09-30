import 'dart:developer';
import 'package:admin_side/color/colors.dart';
import 'package:admin_side/controllers/request.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../data/request.dart';
import '../../../models/request.dart';
import '../../../utils/_system.dart';
import '../../../widgets/datagrid.dart';
import '../../../widgets/on_dashboard.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  var size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    //
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _dataChart(),
            Gap(size.width * 0.030),
            _divider(),
            Gap(size.width * 0.010),
            MyDataTable(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
      child: Divider(
        thickness: 0.1,
        color: SystemColor.mediumGrey,
      ),
    );
  }

//
  Widget _dataChart() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            InkWell(
              onTap: () {
                log('[PLANT CARD] has been tapped.');
              },
              child: DashboardCard(
                cardTitle: 'Plants',
                cardSubtitle: 'Active Plants',
                titleBackground: SystemColor.primaryLighter,
                imagePath: 'assets/images/image1.png',
                barColor: SystemColor.primary,
                currentBarCount: 2000,
                totalBarCount: 2400,
                cardBackgroud: SystemColor.neutralWHite,
                borderColor: SystemColor.primary,
              ),
            ),

            //
            Gap(size.width * 0.01),

            //
            InkWell(
              onTap: () {
                log('[USERS CARD] has been tapped.');
              },
              child: DashboardCard(
                cardTitle: 'Users',
                cardSubtitle: 'Active Users',
                titleBackground: SystemColor.secondaryLighter,
                imagePath: 'assets/images/image2.png',
                barColor: SystemColor.secondary,
                currentBarCount: 1000,
                totalBarCount: 1300,
                cardBackgroud: SystemColor.neutralWHite,
                borderColor: SystemColor.secondary,
              ),
            ),
          ],
        ),

        //
        DashboardRequestCard(
          cardTitle: 'New Request',
          titleBackground: SystemColor.lightGrey,
          cardBackgroud: SystemColor.neutralWHite,
          borderColor: SystemColor.mediumGrey,
          onSeeAll: () {},
        ),
      ],
    );
  }
}

//
class MyDataTable extends StatelessWidget {
  MyDataTable({super.key});

  var screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    //
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _tableTitleStyle(),
          _mainTable(),
        ],
      ),
    );
  }

  Widget _tableTitleStyle() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Currently Working',
            style: TextStyle(
              color: CustomColors.dark.original,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('See All'),
          ),
        ],
      ),
    );
  }

  Widget _mainTable() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.light.original,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.dark.lightest),
      ),
      padding: const EdgeInsets.all(20),
      child: DashboardGridTable(),
    );
  }
}




class DashboardGridTable extends StatelessWidget {
  DashboardGridTable({super.key}) : _dataGridSource = _CustomDataGridSource();

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
