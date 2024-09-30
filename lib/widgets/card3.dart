import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/_system.dart';

class CustomCard3 extends StatelessWidget {
  CustomCard3({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isNew,
  });
  String imagePath;
  String title;
  String subtitle;
  bool isNew;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: SystemColor.neutralWHite,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 100,
            ),
            const Gap(30),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
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
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
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
    );
  }
}
