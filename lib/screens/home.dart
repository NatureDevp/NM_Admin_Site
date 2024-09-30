import 'package:admin_side/color/colors.dart';
import 'package:admin_side/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sidebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // Retrieve the controller
  @override
  Widget build(BuildContext context) {
    SidebarController controller = Get.find<SidebarController>();

    //
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            flex: 1,
            child: SidebarDesktop(),
          ),

          //
          Expanded(
            flex: 5,
            child: Obx(
              () => Scaffold(
                appBar: headerBar(controller.titlePage.value),
                body: controller.selectedPage.value,
              ),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget headerBar(String title) {
    return AppBar(
      surfaceTintColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: CustomColors.dark.original,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      primary: true,
      excludeHeaderSemantics: true,
      automaticallyImplyLeading: false,
      backgroundColor: CustomColors.light.original,
      shape: Border.all(color: CustomColors.dark.lightest),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    );
  }
}
