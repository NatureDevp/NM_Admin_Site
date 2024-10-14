import 'package:flutter/material.dart';

class RequestInformation extends StatelessWidget {
  const RequestInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Center(
            child: Text('Request Information'),
          ),
        ],
      ),
    );
  }
}
