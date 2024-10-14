import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/dt_request.dart';

class RequestListPage extends StatelessWidget {
  const RequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return const SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: RequestTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestTable extends StatelessWidget {
  const RequestTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      columnWidthMode: ColumnWidthMode.fill,
      allowSorting: true,
      source: RequestDataSource(),
      columns: requestColumns(),
    );
  }
}
