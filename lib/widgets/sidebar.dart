import 'package:admin_side/color/colors.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/sidebar.dart';
import '../utils/_system.dart';

class SidebarDesktop extends StatelessWidget {
  const SidebarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    SidebarController controller = Get.find<SidebarController>();
    var screenSize = MediaQuery.of(context).size;

    //
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenSize.height,
        ),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 500,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.010,
            vertical: screenSize.height * 0.030,
          ),
          height: screenSize.height,
          width: screenSize.width,
          color: CustomColors.dark.original,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.width * 0.020),
                child: customTitle(['Nature', 'Medix']),
              ),
              const Gap(20),
              //
              Divider(
                color: SystemColor.mediumGrey,
                thickness: 0.3,
              ),
              //
              const Gap(20),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSubtitle('Main menu'),
                  const Gap(8),
                  Obx(() => SidebarButton(
                        onPressed: () => controller.selectButton(0),
                        isSelected: controller.selectedButtonIndex.value == 0,
                        label: 'Home',
                        icon: Icons.dashboard,
                        isNewNotify: false,
                      )),
                  Obx(() => SidebarButton(
                        onPressed: () => controller.selectButton(1),
                        isSelected: identifyPage(
                                controller.selectedButtonIndex.value) ==
                            1,
                        label: 'Request',
                        icon: Icons.add,
                        isNewNotify: false,
                      )),
                ],
              ),
              //
              const Gap(34),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSubtitle('Manage'),
                  const Gap(8),
                  Obx(() => SidebarButton(
                        onPressed: () => controller.selectButton(2),
                        isSelected: controller.selectedButtonIndex.value == 2,
                        label: 'Plant',
                        icon: Icons.energy_savings_leaf_sharp,
                        isNewNotify: false,
                      )),
                  Obx(
                    () => SidebarButton(
                      onPressed: () => controller.selectButton(3),
                      isSelected: controller.selectedButtonIndex.value == 3,
                      label: 'Users',
                      icon: Icons.people,
                      isNewNotify: false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//

  int identifyPage(int index) {
    List<int> requestpage = [1, 4, 5, 6];

    if (requestpage.contains(index)) {
      return 1;
    }
    return 0;
  }

//
  Widget customTitle(List<String> title) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: title[0],
          style: TextStyle(
            color: CustomColors.light.original,
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
        ),
        const TextSpan(
          text: ' ',
        ),
        TextSpan(
          text: title[1],
          style: TextStyle(
            color: CustomColors.primary.original,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}

//
Widget customSubtitle(String label) {
  return Text(
    label,
    textAlign: TextAlign.left,
    style: TextStyle(
      color: SystemColor.mediumGrey,
      fontSize: 12,
      fontWeight: FontWeight.w200,
    ),
  );
}

class SidebarButton extends StatelessWidget {
  SidebarButton({
    super.key,
    required this.onPressed,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.isNewNotify,
  });

  //
  bool isSelected;
  Function()? onPressed;
  bool isNewNotify;
  String label;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.width * 0.015,
        horizontal: screenSize.width * 0.016,
      ),
      onPressed: onPressed,
      color: isSelected ? SystemColor.primary.withOpacity(0.1) : null,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected ? SystemColor.primary : SystemColor.neutralWHite,
          ),
          const Gap(8),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? SystemColor.primary : SystemColor.neutralWHite,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
          Visibility(
            visible: isNewNotify,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              color: Colors.red,
              child: const Text(
                'New',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
