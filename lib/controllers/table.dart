import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableController {
  RxString searchQuery = ''.obs;
  RxString selectedFilter = 'Filter'.obs;
  RxString selectedStatus = 'Status'.obs;

  List<DataRow> getFilteredRows(List<DataRow> rows) {
    return rows.where((row) {
      bool matchesSearch = searchQuery.value.isEmpty ||
          row.cells.any((cell) => cell.child.toString().contains(searchQuery));
      return matchesSearch;
    }).toList();
  }
}
