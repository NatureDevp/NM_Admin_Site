import 'dart:async';

import 'package:admin_new/models/md_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/api_workplace.dart';

class WorkplaceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    dataRefresh();
  }

  @override
  void onClose() {
    // Dispose of the TabController when no longer needed
    _timer?.cancel();
    tabController.dispose();
    super.onClose();
  }

  late TabController tabController;
  var workplaceRequests = <RequestPlant>[].obs;
  Timer? _timer;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  Future<void> loadPlants(int id) async {
    isLoading.value = true;
    var result = await APIWorkplace.fetchWorkplace(id);

    if (result == null) {
      errorMessage.value = 'Failed to load plants';
      isLoading.value = false;
      return;
    }
    if (result['success'] == false) {
      errorMessage.value = result['message'];
      isLoading.value = false;
      return;
    }

    if (result['data'] == null) {
      errorMessage.value = 'No data found.';
      isLoading.value = false;
      return;
    }

    workplaceRequests.value = convertToRequest(result['data']);

    isLoading.value = false;
    errorMessage.value = '';
  }

  Future<void> _fetchPlants(int id) async {
    var result = await APIWorkplace.fetchWorkplace(id);

    if (result == null) {
      errorMessage.value = 'Failed to load plants';
      return;
    }
    if (result['success'] == false) {
      errorMessage.value = result['message'];

      return;
    }

    if (result['data'] == null) {
      errorMessage.value = 'No data found.';
      return;
    }

    workplaceRequests.value = convertToRequest(result['data']);
    errorMessage.value = '';
  }

  void loadAllData() {
    loadPlants(1);
  }

  List<RequestPlant> convertToRequest(List data) {
    return data.map((value) => RequestPlant.fromJson(value)).toList();
  }

  void dataRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      if (errorMessage.value.isNotEmpty) {
        _timer?.cancel();
        return;
      }
      _fetchPlants(1);
    });
  }
}
