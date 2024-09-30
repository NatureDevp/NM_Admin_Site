import 'package:admin_side/controllers/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../../../utils/_system.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});



  @override
  Widget build(BuildContext context) {
   SidebarController controller = Get.find<SidebarController>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SystemCard.cardStyle3(
            imagePaht: 'assets/images/image3.png',
            title: 'List of Request',
            subtitle:
                'We can Search and Accept a new request based in your perspective.',
            isNew: true,
            ontap: () {
              controller.selectButton(4);
            },
          ),
          SystemCard.cardStyle3(
            imagePaht: 'assets/images/image4.png',
            title: 'My Workplace',
            subtitle:
                'We can easily Track, Find and Create new and finish request.',
            isNew: true,
            ontap: () {
              controller.selectButton(5);
            },
          ),
        ],
      ),
    );
  }
}
