import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/ct_workplace.dart';
import '../../utils/_colors.dart';

class WorkplacePage extends StatelessWidget {
  const WorkplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctWorkplace = Get.put(WorkplaceController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
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
                      controller: ctWorkplace.tabController,
                      indicatorColor: CustomColors.primary.normal,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      labelColor: CustomColors.primary.normal,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelColor: CustomColors.dark.medium,
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: ctWorkplace.tabController,
                        children: [
                          TabBody(
                            controller: ctWorkplace,
                            statusFilter: 'All',
                          ),
                          TabBody(
                            controller: ctWorkplace,
                            statusFilter: 'Ongoing',
                          ),
                          TabBody(
                            controller: ctWorkplace,
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
      var filteredPlants = controller.workplaceRequests.value
          .where(
              (plant) => statusFilter == 'All' || plant.status == statusFilter)
          .toList();

      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: filteredPlants.length + 1,
        itemBuilder: (context, index) {
          if (index - 1 == -1) {
            return CreateNewButton(
              ontap: () {},
            );
          }
          var plant = filteredPlants[index - 1];
          return PlantCard(
            plantname: plant.plant_name,
            status: plant.status,
            date: plant.last_updated,
            plantimage: 'assets/plantImages/plant1.png',
            ontap: () {},
          );
        },
      );
    });
  }
}

class CreateNewButton extends StatelessWidget {
  CreateNewButton({super.key, required this.ontap});
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[700]!, Colors.green[300]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // "Create New" Text
              Text(
                'Create New',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              // Plus Icon
              Icon(
                Icons.add_box_outlined,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  PlantCard({
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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
