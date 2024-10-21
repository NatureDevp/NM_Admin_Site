import 'package:admin_new/utils/_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/ct_home.dart';
import '../../controllers/ct_sidebar.dart';
import '../../utils/_colors.dart';

import '../../utils/_routes.dart';
import '../../utils/_screen_sizes.dart';
import '../../widgets/wg_sidebar.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //

    var ctSidebar = Get.find<SidebarController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Loading...'),
                Gap(10),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      }

      if (controller.isRedirecting.value) {
        Future.delayed(const Duration(seconds: 2), () {
          controller.redirectToLandingPage();
        });
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Redirecting...',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      if (controller.errorMessage.value.isNotEmpty) {
        Future.delayed(const Duration(seconds: 2), () {
          controller.redirectToLandingPage();
        });
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const Gap(10),
                const Text(
                  'Redirecting...',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          var screen = Screen.constraints(constraints);

          return Scaffold(
            drawer: const Sidebar(),
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              primary: true,
              excludeHeaderSemantics: true,
              backgroundColor: CustomColors.light.normal,
              shape: Border.all(color: CustomColors.dark.lightest),
              title: Obx(() {
                return Text(
                  ctSidebar.currentTitle.value,
                  style: TextStyle(
                    color: CustomColors.dark.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                );
              }),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
            body: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: ctSidebar.currentScreen.value,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
