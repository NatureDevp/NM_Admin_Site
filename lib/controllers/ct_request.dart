import 'dart:async';

import 'package:get/get.dart';

import '../api/api_request.dart';
import '../models/md_request.dart';

class RequestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    dataRefresh();
  }

  Timer? _timer;
  var requestData = <RequestPlant>[].obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  var pendingRequestData = <RequestPlant>[].obs;
  var totalRequestPants = 0.obs;

  Future<void> _loadRequests() async {
    isLoading.value = true;
    var result = await APIRequestPlant.fetchRequests();

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

    requestData.value = convertToPlants(result['data']);

    isLoading.value = false;
    errorMessage.value = '';
  }

  Future<void> _fetchRequests() async {
    var result = await APIRequestPlant.fetchRequests();

    if (result == null) {
      errorMessage.value = 'Failed to load requests';
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

    requestData.value = convertToPlants(result['data']);
    errorMessage.value = '';
  }

  void loadAllData() {
    _loadRequests();
    _fetchPendingRequests();
    _totalRequestCounter();
  }

  void _fetchPendingRequests() {
    pendingRequestData.value = requestData.value
        .where((element) => element.status.toLowerCase() == 'pending')
        .toList();
  }

  void _totalRequestCounter() {
    totalRequestPants.value = requestData.value.length;
  }

  List<RequestPlant> convertToPlants(List data) {
    return data.map((value) => RequestPlant.fromJson(value)).toList();
  }

  void dataRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      if (errorMessage.value.isNotEmpty) {
        _timer?.cancel();
        return;
      }
      _fetchRequests();
      _fetchPendingRequests();
      _totalRequestCounter();
    });
  }
}
