import 'package:admin_side/controllers/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/navigation.dart';

class RequestInformation extends StatelessWidget {
  const RequestInformation({super.key});

  @override
  Widget build(BuildContext context) {
    SidebarController sidebarController = Get.put(SidebarController());
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TopNavigation(
            back: () {
              sidebarController.selectButton(1);
            },
          ),
          const Center(
            child: Text('Request Information'),
          ),
        ],
      ),
    );
  }
}
