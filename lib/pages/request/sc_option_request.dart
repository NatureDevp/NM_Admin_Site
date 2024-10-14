import 'package:admin_new/pages/request/sc_list_request.dart';
import 'package:admin_new/utils/_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/ct_sidebar.dart';
import '../../utils/_screen_sizes.dart';

class RequestOptionPage extends StatelessWidget {
  const RequestOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var ctSidebar = Get.find<SidebarController>();

    //
    return LayoutBuilder(builder: (context, constraints) {
      var screen = Screen.constraints(constraints);
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            optionButton(
              context,
              imagePath: 'assets/images/image3.png',
              title: 'List of Request',
              subtitle:
                  'We can Search and Accept a new request based in your perspective.',
              isNew: true,
              onTap: () {
                ctSidebar.changeScreen(
                  ctSidebar.request,
                  'List of Request',
                  screen: const RequestListPage(),
                );
              },
            ),
            optionButton(
              context,
              imagePath: 'assets/images/image4.png',
              title: 'My Workplace',
              subtitle:
                  'We can easily Track, Find and Create new and finish request.',
              isNew: true,
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }

  Widget optionButton(
    context, {
    Function()? onTap,
    String? imagePath,
    String? title,
    String? subtitle,
    bool isNew = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: CustomColors.light.normal,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset(
                imagePath ?? 'assets/images/image5.png',
                height: 100,
              ),
              const Gap(30),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'Title',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle ?? 'Subtitle',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Visibility(
                visible: isNew,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 26,
                  ),
                  child: const Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Gap(30),
              const Icon(
                Icons.arrow_right,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
