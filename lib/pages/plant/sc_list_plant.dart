import 'dart:developer';

import 'package:admin_new/utils/_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../controllers/ct_plant.dart';
import '../../data/dt_plant.dart';

class PlantListPage extends GetView<PlantController> {
  const PlantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(controller.errorMessage.value),
            const Gap(10),
            MaterialButton(
              textColor: CustomColors.light.normal,
              color: CustomColors.error.normal,
              onPressed: () {
                controller.loadAllData();
              },
              child: const Text('Reload'),
            )
          ],
        );
      }

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
                child: PlantTable(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class PlantTable extends GetView<PlantController> {
  const PlantTable({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SfDataGrid(
        source: PlantDataSource(controller.plantData.value),
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: plantColumns(),
      );
    });
  }
}
