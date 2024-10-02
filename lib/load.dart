import 'dart:developer';

import 'package:admin_side/data/plants.dart';
import 'package:admin_side/screens/landing.dart';
import 'package:admin_side/utils/_system.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'api/plant.dart';
import 'models/plant.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder(
        future: API.getPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingtResources('Loading Plant Resources');
          }
          if (IS_DEBUG_MODE) {
            return const LandingPage();
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return _resourceError('Resources failed to load');
          }

          if (snapshot.hasError) {
            return _resourceError('Resources failed to load');
          }

          if (!snapshot.hasData) {
            return _resourceError('Resources failed to load');
          }

          return const LandingPage();
        },
      );
    } catch (e) {
      return _resourceError('Resources failed to load');
    }
  }

  Widget _loadingtResources(String label) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label),
            const Gap(20),
            const CircularProgressIndicator(),
          ],
        ),
      )),
    );
  }

  Widget _resourceError(String label) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      )),
    );
  }

  List<Plants> _getAllPlants(List? data) {
    if (data == null) {
      return [];
    }
    return data.map((value) => Plants.fromJson(value)).toList();
  }
}
