import 'package:admin_new/controllers/ct_plant.dart';
import 'package:admin_new/controllers/ct_request.dart';
import 'package:admin_new/controllers/ct_workplace.dart';
import 'package:admin_new/data/dt_workplace.dart';
import 'package:admin_new/models/md_request.dart';
import 'package:admin_new/utils/_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../utils/_colors.dart';
import '../../utils/_screen_sizes.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  late Screen screen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        screen = Screen.constraints(constraints);
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screen.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDataChart(),
                Gap(screen.width * 0.03),
                _buildDivider(),
                Gap(screen.width * 0.03),
                _buildTableTitle(),
                Gap(screen.width * 0.009),
                _workplaceTable(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableTitle() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Currently Working',
            style: TextStyle(
              color: CustomColors.dark.normal,
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

  Widget _workplaceTable() {
    var controller = Get.find<WorkplaceController>();
    return Obx(() {
      return SfDataGrid(
        source: WorkplaceDataSource(controller.workplaceRequests.value),
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: workplaceColumns(),
      );
    });
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.2),
      child: Divider(
        thickness: 0.1,
        color: CustomColors.dark.medium,
      ),
    );
  }

  Widget _buildDataChart() {
    final ctRequest = Get.find<RequestController>();
    final ctPlant = Get.find<PlantController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Obx(
              () => _buildDashboardCard(
                title: 'Plants',
                subtitle: 'Active Plants',
                titleBgColor: CustomColors.primary.lighter,
                imagePath: 'assets/images/image1.png',
                barColor: CustomColors.primary.normal,
                currentCount: ctPlant.activePlantCount.value.toDouble(),
                totalCount: ctPlant.totalPants.toDouble(),
              ),
            ),
            Gap(screen.width * 0.01),
            _buildDashboardCard(
              title: 'Users',
              subtitle: 'Active Users',
              titleBgColor: CustomColors.secondary.lighter,
              imagePath: 'assets/images/image2.png',
              barColor: CustomColors.secondary.normal,
              currentCount: 1000,
              totalCount: 1300,
            ),
          ],
        ),
        _buildDashboardRequestCard(),
      ],
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String subtitle,
    required Color titleBgColor,
    required String imagePath,
    required Color barColor,
    required double currentCount,
    required double totalCount,
  }) {
    final cardWidth = (screen.width / 2) - 110;
    final barSize =
        currentCount / (totalCount == 0 ? 1 : totalCount) * cardWidth;

    return Container(
      padding: EdgeInsets.all(screen.width * 0.01),
      width: cardWidth,
      decoration: BoxDecoration(
        color: CustomColors.light.normal,
        borderRadius: BorderRadius.circular(screen.width * 0.012),
        border: Border.all(color: barColor),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardTitle(title, titleBgColor),
                Gap(screen.width * 0.02),
                _buildBarGraph(barSize, barColor),
                Gap(screen.width * 0.01),
                _buildCardData(currentCount, totalCount, subtitle),
              ],
            ),
          ),
          Gap(screen.width * 0.02),
          Expanded(
            flex: 1,
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTitle(String title, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screen.width * 0.005,
        vertical: screen.width * 0.002,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: CustomColors.dark.normal,
          fontSize: screen.width * 0.01,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBarGraph(double width, Color color) {
    return Container(
      height: screen.width * 0.0045,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screen.width * 0.004),
        color: CustomColors.dark.medium,
      ),
      child: Container(
        width: width,
        height: screen.width * 0.0045,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screen.width * 0.004),
          color: color,
        ),
      ),
    );
  }

  Widget _buildCardData(
      double currentCount, double totalCount, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$currentCount',
            style: TextStyle(
              color: Colors.black,
              fontSize: screen.width * 0.03,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '/$totalCount',
                style: TextStyle(
                  color: CustomColors.dark.medium,
                  fontSize: screen.width * 0.015,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: CustomColors.dark.medium,
            fontSize: screen.width * 0.01,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardRequestCard() {
    final cardWidth = (screen.width / 2) - 110;

    return Container(
      padding: EdgeInsets.all(screen.width * 0.01),
      width: cardWidth,
      height: screen.width * 0.258,
      decoration: BoxDecoration(
        color: CustomColors.light.normal,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColors.dark.medium),
      ),
      child: Column(
        children: [
          _buildRequestCardTitle('New Request', CustomColors.dark.lighter),
          Expanded(
            child: _buildRequestCardBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCardTitle(String title, Color bgColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screen.width * 0.016,
            vertical: screen.width * 0.002,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(screen.width * 0.004),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: CustomColors.dark.normal,
              fontSize: screen.width * 0.01,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See all',
            style: TextStyle(
              color: CustomColors.dark.normal,
              fontSize: screen.width * 0.01,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestCardBody() {
    var controller = Get.find<RequestController>();
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.symmetric(vertical: screen.width * 0.01),
        itemCount: controller.pendingRequestData.value.length,
        itemBuilder: (_, index) {
          final request = controller.pendingRequestData.value[index];
          return _buildRequestCardTile(request);
        },
      ),
    );
  }

  Widget _buildRequestCardTile(RequestPlant request) {
    var controller = Get.find<RequestController>();
    return GestureDetector(
      onTap: () {
        controller.selectedId.value = request.id;
        Get.toNamed(Routes.getRequestInfoPage);
      },
      child: Card(
        color: CustomColors.light.normal,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screen.width * 0.01,
            horizontal: screen.width * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPlantDetail(request),
              _buildRequestDetail(request),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantDetail(RequestPlant request) {
    return Row(
      children: [
        Image.asset(
          'assets/images/image1.png',
          height: screen.width * 0.03,
        ),
        Gap(screen.width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.plant_name,
              style: TextStyle(
                fontSize: screen.width * 0.012,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              request.scientific_name,
              style: TextStyle(
                fontSize: screen.width * 0.01,
                color: CustomColors.dark.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequestDetail(RequestPlant request) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          request.date_created,
          style: TextStyle(
            fontSize: screen.width * 0.01,
            color: CustomColors.dark.medium,
          ),
        ),
        Gap(screen.width * 0.004),
        _banner(request.status),
      ],
    );
  }

  Widget _banner(String status) {
    return Container(
      padding: EdgeInsets.all(screen.width * 0.003),
      decoration: BoxDecoration(
        color: CustomColors.primary.normal,
        borderRadius: BorderRadius.circular(screen.width * 0.005),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontSize: screen.width * 0.009,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
