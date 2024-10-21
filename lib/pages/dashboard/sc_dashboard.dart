import 'package:admin_new/controllers/ct_plant.dart';
import 'package:admin_new/controllers/ct_request.dart';
import 'package:admin_new/controllers/ct_workplace.dart';
import 'package:admin_new/data/dt_workplace.dart';
import 'package:admin_new/models/md_request.dart';
import 'package:admin_new/pages/request/sc_request_info.dart';
import 'package:admin_new/utils/_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/_colors.dart';
import '../../utils/_screen_sizes.dart';
import '../request/sc_list_request.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  @override
  late Screen screen;

  @override
  Widget build(BuildContext context) {
    //

    return LayoutBuilder(builder: (context, constraints) {
      screen = Screen.constraints(constraints);

      //
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screen.width * 0.03),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _dataChart(),
              Gap(screen.width * 0.030),
              _divider(),
              Gap(screen.width * 0.030),
              _tableTitleStyle(),
              Gap(screen.width * 0.009),
              const WorkplaceTable(),
            ],
          ),
        ),
      );
    });
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

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.2),
      child: Divider(
        thickness: 0.1,
        color: CustomColors.dark.medium,
      ),
    );
  }

//
  Widget _dataChart() {
    var ctRequest = Get.find<RequestController>();
    var ctPlant = Get.find<PlantController>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            Obx(
              () => DashboardCard(
                screen,
                cardTitle: 'Plants',
                cardSubtitle: 'Active Plants',
                titleBackground: CustomColors.primary.lighter,
                imagePath: 'assets/images/image1.png',
                barColor: CustomColors.primary.normal,
                currentBarCount: ctPlant.activePlantCount.value.toDouble(),
                totalBarCount: ctPlant.totalPants.toDouble(),
                cardBackgroud: CustomColors.light.normal,
                borderColor: CustomColors.primary.normal,
              ),
            ),

            //
            Gap(screen.width * 0.01),

            //
            DashboardCard(
              screen,
              cardTitle: 'Users',
              cardSubtitle: 'Active Users',
              titleBackground: CustomColors.secondary.lighter,
              imagePath: 'assets/images/image2.png',
              barColor: CustomColors.secondary.normal,
              currentBarCount: 1000,
              totalBarCount: 1300,
              cardBackgroud: CustomColors.light.normal,
              borderColor: CustomColors.secondary.normal,
            ),
          ],
        ),

        //
        DashboardRequestCard(
          screen,
          cardTitle: 'New Request',
          titleBackground: CustomColors.dark.lighter,
          cardBackgroud: CustomColors.light.normal,
          borderColor: CustomColors.dark.medium,
          onSeeAll: () {},
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  DashboardCard(
    this.screen, {
    super.key,
    required this.cardTitle,
    required this.titleBackground,
    required this.barColor,
    required this.currentBarCount,
    required this.totalBarCount,
    required this.cardSubtitle,
    required this.imagePath,
    required this.cardBackgroud,
    required this.borderColor,
  });
  String cardTitle;
  String cardSubtitle;
  Color cardBackgroud;
  Color borderColor;
  Color titleBackground;
  String imagePath;
  Color barColor;
  double currentBarCount;
  double totalBarCount;
  double barsize = 0.0;
  Screen screen;
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      padding: EdgeInsets.all(screen.width * 0.01),
      width: (screen.width / 2) - 110,
      decoration: BoxDecoration(
        color: cardBackgroud,
        borderRadius: BorderRadius.circular(screen.width * 0.012),
        border: Border.all(
          color: borderColor,
        ),
      ),

      //
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                barsize = constraints.maxWidth;

                //
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardTitleStyle(),
                    Gap(screen.width * 0.02),
                    barGraph(),
                    Gap(screen.width * 0.01),
                    cardData(),
                  ],
                );
              },
            ),
          ),

          //
          Gap(screen.width * 0.02),

          //
          Expanded(
            flex: 1,
            child: Image.asset(
              imagePath,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardTitleStyle() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screen.width * 0.005,
        vertical: screen.width * 0.002,
      ),
      decoration: BoxDecoration(
        color: titleBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        cardTitle,
        style: TextStyle(
          color: CustomColors.dark.normal,
          fontSize: screen.width * 0.01,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //
  Widget barGraph() {
    return Container(
      height: screen.width * 0.0045,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screen.width * 0.004),
        color: CustomColors.dark.medium,
      ),
      child: Container(
        width: calculatePercentage(),
        height: screen.width * 0.0045,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screen.width * 0.004),
          color: barColor,
        ),
      ),
    );
  }

  double calculatePercentage() {
    double tempTOTAL = 0;
    if (totalBarCount == 0) {
      tempTOTAL = 1;
    } else {
      tempTOTAL = totalBarCount;
    }
    double totalPercentage = (currentBarCount / tempTOTAL);
    totalPercentage = (barsize * totalPercentage);
    return totalPercentage;
  }

  Widget cardData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: '$currentBarCount',
            style: TextStyle(
              color: Colors.black,
              fontSize: screen.width * 0.03,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '/$totalBarCount',
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
          cardSubtitle,
          style: TextStyle(
            color: CustomColors.dark.medium,
            fontSize: screen.width * 0.01,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class WorkplaceTable extends GetView<WorkplaceController> {
  const WorkplaceTable({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SfDataGrid(
        source: WorkplaceDataSource(controller.workplaceRequests.value),
        allowSorting: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: workplaceColumns(),
      );
    });
  }
}
//===============================

class DashboardRequestCard extends GetView<RequestController> {
  DashboardRequestCard(
    this.screen, {
    super.key,
    required this.cardTitle,
    required this.titleBackground,
    required this.cardBackgroud,
    required this.borderColor,
    required this.onSeeAll,
  });
  String cardTitle;
  Color cardBackgroud;
  Color borderColor;
  Color titleBackground;
  Function()? onSeeAll;
  Screen screen;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screen.width * 0.01),
      width: (screen.width / 2) - 110,
      height: screen.width * 0.258,
      decoration: BoxDecoration(
        color: cardBackgroud,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),

      //
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cardTitleStye(),
          Expanded(child: _cardBody()),
        ],
      ),
    );
  }

  Widget _cardTitleStye() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screen.width * 0.016,
            vertical: screen.width * 0.002,
          ),
          decoration: BoxDecoration(
            color: titleBackground,
            borderRadius: BorderRadius.circular(screen.width * 0.004),
          ),
          child: Text(
            cardTitle,
            style: TextStyle(
              color: CustomColors.dark.normal,
              fontSize: screen.width * 0.01,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            'See all',
            style: TextStyle(
              color: CustomColors.dark.normal,
              fontSize: screen.width * 0.01,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardBody() {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
          height: constraint.maxHeight,
          child: Obx(() {
            return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: screen.width * 0.01),
                shrinkWrap: true,
                itemCount: controller.pendingRequestData.value.length,
                itemBuilder: (_, index) {
                  List<RequestPlant> requests =
                      controller.pendingRequestData.value;
                  return InkWell(
                    onTap: () {
                      controller.selectRequest(requests[index]);
                      Get.toNamed(Routes.getRequestInfoPage);
                    },
                    child: _cardTile(requests[index]),
                  );
                });
          }));
    });
  }

  Widget _cardTile(RequestPlant request) {
    return Card(
      color: CustomColors.light.normal,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screen.width * 0.01,
          horizontal: screen.width * 0.02,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _plantDetail(request),
            ),
            Align(
              alignment: const Alignment(0.3, 0),
              child: _requestDetail(request),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _banner(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _plantDetail(RequestPlant request) {
    return Row(
      children: [
        Image.asset(
          'assets/images/image1.png',
          height: screen.width * 0.03,
        ),
        Gap(screen.width * 0.009),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              request.plant_name,
              style: TextStyle(
                fontSize: screen.width * 0.009,
                fontWeight: FontWeight.bold,
                color: CustomColors.dark.normal,
              ),
            ),
            Text(
              request.scientific_name,
              style: TextStyle(
                fontSize: screen.width * 0.009,
                fontWeight: FontWeight.w400,
                color: CustomColors.dark.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

//
  Widget _requestDetail(RequestPlant request) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.date_created,
            style: TextStyle(
              fontSize: screen.width * 0.008,
              fontWeight: FontWeight.w800,
              color: CustomColors.dark.normal,
            ),
          ),
          Text(
            'Requested date',
            style: TextStyle(
              fontSize: screen.width * 0.009,
              fontWeight: FontWeight.w300,
              color: CustomColors.dark.medium,
            ),
          ),
        ]);
  }

//
  Widget _banner() {
    return Container(
      padding: EdgeInsets.all(screen.width * 0.003),
      decoration: BoxDecoration(
        color: CustomColors.primary.normal,
        borderRadius: BorderRadius.circular(screen.width * 0.005),
      ),
      child: Text(
        'New',
        style: TextStyle(
          color: Colors.white,
          fontSize: screen.width * 0.009,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
