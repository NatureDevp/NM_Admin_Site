import 'package:admin_new/controllers/ct_landing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utils/_routes.dart';
import '../../utils/_screen_sizes.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.setWindowTitle('NatureMedix');

    return LayoutBuilder(builder: (context, constraints) {
      var screen = Screen.constraints(constraints);

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            _buildBackground(),
            _buildContent(screen),
          ],
        ),
      );
    });
  }

  // Background container
  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFFF2F7FA)),
    );
  }

  // Main content (text, image, buttons)
  Widget _buildContent(Screen screen) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screen.width / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(screen.width / 50),
              _buildTitle(screen),
              Gap(screen.width / 70),
              _buildSubtitle(screen),
              Gap(screen.width / 70),
              _buildImage(screen),
              Gap(screen.width / 60),
              _buildLoginButton(screen),
              const Gap(15),
              _buildSignupButton(screen),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }

  // Title widget
  Widget _buildTitle(Screen screen) {
    return Text(
      'NATUREMEDIX ADMIN PANEL',
      style: TextStyle(
        fontSize: screen.width / 50,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
        color: Colors.teal,
      ),
    );
  }

  // Subtitle widget
  Widget _buildSubtitle(Screen screen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.width / 40),
      child: Text(
        '“Manage herbal plant information effectively and enhance user experience for natural remedies.”',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screen.width / 80,
          color: Colors.teal,
        ),
      ),
    );
  }

  // Image widget
  Widget _buildImage(Screen screen) {
    return Image.asset(
      'assets/images/bg5.png',
      fit: BoxFit.cover,
      height: screen.width / 6,
    );
  }

  // Login button
  Widget _buildLoginButton(Screen screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.teal,
      ),
      onPressed: () {
        Get.toNamed(Routes.getLoginPage);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screen.width / 100,
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
            fontSize: screen.width / 80,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Sign-up button
  Widget _buildSignupButton(Screen screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.teal, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        Get.toNamed(Routes.getSignupPage);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screen.width / 100,
        ),
        child: Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: screen.width / 80,
            letterSpacing: 1.5,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
