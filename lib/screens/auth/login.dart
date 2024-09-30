import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../routes/pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('LOGIN PAGE'),
          const Gap(30),
          TextFormField(),
          const Gap(20),
          TextFormField(),
          const Gap(20),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(SystemPage.getMainpage);
              },
              child: const Text('login'))
        ],
      ),
    );
  }
}
