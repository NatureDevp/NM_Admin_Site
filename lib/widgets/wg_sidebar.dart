import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/ct_sidebar.dart';
import '../pages/dashboard/sc_dashboard.dart';
import '../pages/plant/sc_list_plant.dart';
import '../pages/request/sc_option_request.dart';
import '../pages/user/sc_user.dart';
import '../utils/_colors.dart';
import '../utils/_screen_sizes.dart';

class Sidebar extends GetView<SidebarController> {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screen = Screen.constraints(constraints);

        //
        return Drawer(
          backgroundColor: CustomColors.dark.normal,
          width: screen.width / 5.5,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screen.height,
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 500,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screen.width * 0.010,
                  vertical: screen.height * 0.030,
                ),
                height: screen.height,
                width: screen.width,
                color: CustomColors.dark.normal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screen.width * 0.020),
                      child: customTitle(['Nature', 'Medix']),
                    ),
                    const Gap(20),
                    //
                    Divider(
                      color: CustomColors.dark.medium,
                      thickness: 0.3,
                    ),
                    //
                    const Gap(20),

                    //
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customSubtitle('Main menu'),
                          const Gap(8),
                          sidebarButton(
                            context,
                            onPressed: () {
                              controller.changeScreen(
                                controller.dash,
                                'Dashboard',
                                screen: Dashboard(),
                              );
                              Navigator.pop(context);
                            },
                            isSelected:
                                controller.isSelectedButton(controller.dash),
                            label: 'Home',
                            icon: Icons.dashboard,
                            isNewNotify: false,
                          ),
                          sidebarButton(
                            context,
                            onPressed: () {
                              controller.changeScreen(
                                controller.request,
                                'Request',
                                screen: const RequestOptionPage(),
                              );
                              Navigator.pop(context);
                            },
                            isSelected:
                                controller.isSelectedButton(controller.request),
                            label: 'Request',
                            icon: Icons.add,
                            isNewNotify: false,
                          ),
                        ],
                      ),
                    ),
                    //
                    const Gap(34),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customSubtitle('Manage'),
                          const Gap(8),
                          sidebarButton(
                            context,
                            onPressed: () {
                              controller.changeScreen(
                                controller.plant,
                                'Plants',
                                screen: const PlantListPage(),
                              );
                              Navigator.pop(context);
                            },
                            isSelected:
                                controller.isSelectedButton(controller.plant),
                            label: 'Plant',
                            icon: Icons.energy_savings_leaf_sharp,
                            isNewNotify: false,
                          ),
                          sidebarButton(
                            context,
                            onPressed: () {
                              controller.changeScreen(
                                controller.user,
                                'Users',
                                screen: const UserListPage(),
                              );
                              Navigator.pop(context);
                            },
                            isSelected:
                                controller.isSelectedButton(controller.user),
                            label: 'Users',
                            icon: Icons.people,
                            isNewNotify: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget sidebarButton(
    BuildContext context, {
    bool isSelected = false,
    Function()? onPressed,
    bool isNewNotify = false,
    String label = 'button',
    IconData? icon,
  }) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.width * 0.015,
        horizontal: screenSize.width * 0.016,
      ),
      onPressed: onPressed,
      color: isSelected ? CustomColors.primary.normal.withOpacity(0.1) : null,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected
                ? CustomColors.primary.normal
                : CustomColors.light.normal,
          ),
          const Gap(8),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? CustomColors.primary.normal
                  : CustomColors.light.normal,
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

  Widget customTitle(List<String> title) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: title[0],
          style: TextStyle(
            color: CustomColors.light.normal,
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
            color: CustomColors.primary.normal,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  Widget customSubtitle(String label) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: CustomColors.dark.medium,
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
