import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/_system.dart';

class TopNavigation extends StatelessWidget {
  TopNavigation({super.key, this.label = '', required this.back, this.goTo});
  String label;
  Function()? back;
  Function()? goTo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: label == ''
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(SystemColor.mediumGrey),
          ),
          onPressed: back,
          label: const Text('Back'),
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
        TextButton.icon(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(SystemColor.primary),
          ),
          onPressed: goTo,
          label: Text(
            label,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: SystemColor.primary,
            ),
          ),
        ),
      ],
    );
  }
}
