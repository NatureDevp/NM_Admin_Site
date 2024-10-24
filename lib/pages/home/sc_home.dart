import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/ct_home.dart';
import '../../controllers/ct_sidebar.dart';
import '../../utils/_colors.dart';
import '../../utils/_screen_sizes.dart';
import '../../widgets/wg_sidebar.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var ctSidebar = Get.find<SidebarController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoadingScreen();
      } else if (controller.isRedirecting.value) {
        _redirectAfterDelay();
        return _buildRedirectingScreen();
      } else if (controller.errorMessage.value.isNotEmpty) {
        _redirectAfterDelay();
        return _buildErrorScreen(controller.errorMessage.value);
      } else {
        return _buildMainContent(ctSidebar);
      }
    });
  }

  // Loading Screen Widget
  Widget _buildLoadingScreen() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading...'),
            Gap(10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  // Redirecting Screen Widget
  Widget _buildRedirectingScreen() {
    return const Scaffold(
      body: Center(
        child: Text('Redirecting...', textAlign: TextAlign.center),
      ),
    );
  }

  // Error Screen Widget
  Widget _buildErrorScreen(String errorMessage) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            const Gap(10),
            const Text('Redirecting...', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // Redirects to Landing Page After Delay
  void _redirectAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      controller.redirectToLandingPage();
    });
  }

  // Main Content Widget
  Widget _buildMainContent(SidebarController ctSidebar) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screen = Screen.constraints(constraints);

        return Scaffold(
          drawer: const Sidebar(),
          appBar: _buildAppBar(ctSidebar),
          body: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
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
  }

  // App Bar Widget
  AppBar _buildAppBar(SidebarController ctSidebar) {
    return AppBar(
      surfaceTintColor: Colors.white,
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
    );
  }
}
