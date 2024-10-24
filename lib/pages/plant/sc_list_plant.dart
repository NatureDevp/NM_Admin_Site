import 'dart:developer';
import 'package:admin_new/utils/_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../controllers/ct_plant.dart';
import '../../data/dt_plant.dart';
import '../../utils/_routes.dart';

class PlantListPage extends GetView<PlantController> {
  const PlantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoadingIndicator();
        // } else if (controller.errorMessage.value.isNotEmpty) {
        //   return _buildErrorScreen();
      } else {
        return _buildPlantListContent();
      }
    });
  }

  // Loading Indicator Widget
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Error Screen Widget
  Widget _buildErrorScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(controller.errorMessage.value),
        const Gap(10),
        MaterialButton(
          textColor: CustomColors.light.normal,
          color: CustomColors.error.normal,
          onPressed: controller.loadAllData,
          child: const Text('Reload'),
        )
      ],
    );
  }

  // Main Plant List Content
  Widget _buildPlantListContent() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const Gap(20),
              _buildPlantTable(),
            ],
          ),
        ),
      ),
    );
  }

  // Header with Buttons
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // TextButton.icon(
        //   style: ElevatedButton.styleFrom(
        //     foregroundColor: CustomColors.dark.normal,
        //   ),
        //   onPressed: () {},
        //   label: const Text('Back'),
        //   icon: const Icon(Icons.arrow_back),
        // ),

        TextButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: CustomColors.light.normal,
            backgroundColor: CustomColors.primary.normal,
          ),
          onPressed: () {
            print('Create New');
            Get.toNamed(Routes.getCreatePlantPage);
          },
          child: const Text('Create New'),
        ),
      ],
    );
  }

  // Plant Table Widget
  Widget _buildPlantTable() {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth,
          height: 600,
          child: _buildPlantTableContent(),
        );
      },
    );
  }

  // Function to Create Plant Table
  Widget _buildPlantTableContent() {
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
