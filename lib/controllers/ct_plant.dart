import 'dart:async';

import 'package:get/get.dart';

import '../api/api_plant.dart';
import '../models/md_plant.dart';

class PlantController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadPlants();
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
  var plantData = <Plants>[].obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  var activePlantCount = 0.obs;
  var totalPants = 0.obs;
  Future<void> loadPlants() async {
    isLoading.value = true;
    var result = await APIPlant.fetchPlants();

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

    plantData.value = convertToPlants(result['data']);

    isLoading.value = false;
    errorMessage.value = '';
  }

  Future<void> _fetchPlants() async {
    var result = await APIPlant.fetchPlants();

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

    plantData.value = convertToPlants(result['data']);
    errorMessage.value = '';
  }

  void loadAllData() {
    loadPlants();
    _activeCounter();
    _totalPlantCounter();
  }

  void _activeCounter() {
    activePlantCount.value = plantData.value
        .where((element) => element.status.toLowerCase() == 'active')
        .toList()
        .length;
  }

  void _totalPlantCounter() {
    totalPants.value = plantData.value.length;
  }

  List<Plants> convertToPlants(List data) {
    return data.map((value) => Plants.fromJson(value)).toList();
  }

  void dataRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      if (errorMessage.value.isNotEmpty) {
        _timer?.cancel();
        return;
      }
      _fetchPlants();
      _activeCounter();
      _totalPlantCounter();
    });
  }
}
