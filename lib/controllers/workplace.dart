import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkplaceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var plantRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);

    // Load initial plant requests (mock data for now)
    plantRequests.assignAll([
      {'name': 'Aloe Vera', 'status': 'New', 'date': 'Accepted at June 27'},
      {
        'name': 'Rosemary',
        'status': 'Ongoing',
        'date': 'Last modify at June 26'
      },
      {
        'name': 'Basil',
        'status': 'Completed',
        'date': 'Last upload at June 26'
      },
      {
        'name': 'Thyme',
        'status': 'Completed',
        'date': 'Last upload at June 26'
      },
    ]);
  }

  @override
  void onClose() {
    // Dispose of the TabController when no longer needed
    tabController.dispose();
    super.onClose();
  }
}
