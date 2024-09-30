import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../routes/pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('LANDING PAGE'),
            const Gap(30),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(SystemPage.getLoginPage);
                },
                child: const Text('Login')),
            const Gap(20),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(SystemPage.getSignupPage);
                },
                child: const Text('Singup'))
          ],
        ),
      ),
    );
  }
}
