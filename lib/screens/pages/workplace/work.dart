import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controllers/sidebar.dart';
import '../../../controllers/workplace.dart';
import '../../../routes/pages.dart';
import '../../../utils/_system.dart';

import '../../../widgets/createcard.dart';
import '../../../widgets/header.dart';
import '../../../widgets/navigation.dart';

class WorkplacePage extends StatelessWidget {
  const WorkplacePage({super.key});

  @override
  Widget build(BuildContext context) {
      SidebarController sidebatcontroller = Get.find<SidebarController>();
    final WorkplaceController controller = Get.find<WorkplaceController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: TopNavigation(
            label: 'Request List',
            back: () {
            sidebatcontroller.selectButton(1);
            },
            goTo: () {
          sidebatcontroller.selectButton(4);
            },
          ),
        ),
        const Gap(5),
        Divider(
          color: SystemColor.mediumGrey,
          thickness: 0.1,
        ),
        const Gap(5),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Scaffold(
                body: Column(
                  children: [
                    TabBar(
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'In progress'),
                        Tab(text: 'Completed'),
                      ],
                      controller: controller.tabController,
                      indicatorColor: SystemColor.primary,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      labelColor: SystemColor.primary,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelColor: SystemColor.mediumGrey,
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          TabBody(
                            controller: controller,
                            statusFilter: 'All',
                          ),
                          TabBody(
                            controller: controller,
                            statusFilter: 'Ongoing',
                          ),
                          TabBody(
                            controller: controller,
                            statusFilter: 'Completed',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TabBody extends StatelessWidget {
  TabBody({super.key, required this.controller, required this.statusFilter});
  String statusFilter;
  WorkplaceController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var filteredPlants = controller.plantRequests
          .where((plant) =>
              statusFilter == 'All' || plant['status'] == statusFilter)
          .toList();

      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: filteredPlants.length + 1,
        itemBuilder: (context, index) {
          if (index - 1 == -1) {
            return CreateNewCard(
              ontap: () {},
            );
          }
          var plant = filteredPlants[index - 1];
          return Card4(
            plantname: plant['name'],
            status: plant['status'],
            date: plant['date'],
            plantimage: 'assets/plantImages/plant1.png',
            ontap: () {},
          );
        },
      );
    });
  }
}

class Card4 extends StatelessWidget {
  Card4({
    super.key,
    required this.plantname,
    required this.status,
    required this.date,
    required this.plantimage,
    required this.ontap,
  });
  String plantname;
  String plantimage;
  String status;
  String date;
  Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
    
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New Tag
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(
                  status,
                  style: TextStyle(
                    color:
                        (status == 'Completed') ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Plant Image (Placeholder for now)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    plantimage, // Replace with your actual image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Plant Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                plantname,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Date
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'New':
        return const Color(0xFF93F396);
      case 'Ongoing':
        return const Color(0xFFF8D093);
      case 'Completed':
        return const Color(0xFF00A308);
      default:
        return Colors.grey;
    }
  }
}
