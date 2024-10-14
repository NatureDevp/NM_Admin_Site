import 'package:get/get.dart';

class FormController extends GetxController {
  RxBool passwordVisible = false.obs;

  bool get isPasswordVisible => passwordVisible.value;
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }
}
