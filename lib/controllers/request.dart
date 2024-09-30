import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../data/request.dart';
import '../models/request.dart';

class RequestController extends GetxController {}





/*

 late final List<Request> _request = REQUESTS.obs;
  late List<Request> _filteredRequest;

  String onRowTap(DataGridRow row) {
    var cells = row.getCells();
    final id = cells[0].value; // Get the ID value
    final name = cells[1].value; // Get the Name value

    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Row Tapped'),
        content: Text('ID: $id\nName: $name'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    return id;
  }
 */