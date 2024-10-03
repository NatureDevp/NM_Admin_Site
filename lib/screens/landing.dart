import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../routes/pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFFF2F7FA)),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(20),
                    const Text(
                      'NATUREMEDIX ADMIN PANEL',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.teal,
                      ),
                    ),
                    const Gap(15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        '“Manage herbal plant information effectively and enhance user experience for natural remedies.”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    const Gap(20),
                    Image.asset(
                      'assets/images/bg5.png',
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                    const Gap(30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        Get.toNamed(SystemPage.getLoginPage);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.teal, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed(SystemPage.getSignupPage);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.5,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                    const Gap(50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
