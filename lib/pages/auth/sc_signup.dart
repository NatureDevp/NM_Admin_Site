import 'dart:developer';

import 'package:admin_new/api/api_auth.dart';
import 'package:admin_new/utils/_colors.dart';
import 'package:admin_new/utils/_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../../controllers/ct_form.dart';
import '../../controllers/ct_signup.dart';
import '../../models/md_auth.dart';
import '../../utils/_local_storage.dart';
import '../../validators/vt_forms.dart';

class SignupPage extends GetView<SignupPageController> {
  SignupPage({super.key});

  final FormController ctForm = Get.find<FormController>();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void register() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: CustomColors.error.normal,
        ),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: Get.context!,
      barrierColor: CustomColors.dark.normal.withOpacity(0.8),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
            child: CircularProgressIndicator(
          color: CustomColors.error.normal,
        ));
      },
    );

    //
    try {
      var results = await APIAuth.register(Authorization(
        firstName: _firstname.text,
        lastName: _lastname.text,
        email: _email.text,
        password: _password.text,
        passwordConfirmation: _confirmPassword.text,
      ));

      Navigator.pop(Get.context!);

      if (results == null || results['success'] == false) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Registration failed!',
          text: results!['message'],
          confirmBtnText: 'Ok',
          confirmBtnColor: CustomColors.error.normal,
          onConfirmBtnTap: () {
            Navigator.of(Get.context!).pop();
          },
        );
        return;
      }
      var auth = Authorization.fromJson(results['data'], null);
      // Show success message
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        barrierDismissible: false,
        title: 'Registered Successfully',
        text: 'Welcome ${auth.firstName} ${auth.lastName}!',
        confirmBtnText: 'Continue',
        confirmBtnColor: CustomColors.primary.normal,
        onConfirmBtnTap: () {
          Navigator.of(Get.context!).pop();
          Get.offAllNamed(Routes.getLoginPage);
        },
      );
    } catch (error) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.warning,
        title: 'Registration failed!',
        text: 'Something went wrong. Please try again.',
        confirmBtnText: 'Ok',
        confirmBtnColor: CustomColors.error.normal,
        onConfirmBtnTap: () {
          Navigator.of(Get.context!).pop();
        },
      );
    }
  }

  // Reset all text fields
  void _resetFields() {
    _firstname.clear();
    _lastname.clear();
    _email.clear();
    _password.clear();
    _confirmPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    hasSessionToken().then((isLoggedIn) {
      if (isLoggedIn) {
        Get.offAllNamed(Routes.getHomePage);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: _buildForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg6.png'),
                fit: BoxFit.cover,
              ),
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
          ),
          const Center(
            child: Text(
              'NATUREMEDIX ADMIN SIGNUP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(20),
          _buildTitle(),
          const Gap(30),
          _buildTextField(
            controller: _firstname,
            label: 'Firstname',
            icon: Icons.person,
            validator: validateFirstName,
          ),
          const Gap(20),
          _buildTextField(
            controller: _lastname,
            label: 'Lastname',
            icon: Icons.person,
            validator: validateLastName,
          ),
          const Gap(20),
          _buildTextField(
            controller: _email,
            label: 'Email',
            icon: Icons.email,
            validator: validateEmail,
          ),
          const Gap(20),
          _buildPasswordField(_password, 'Password'),
          const Gap(20),
          _buildPasswordField(_confirmPassword, 'Confirm Password',
              isConfirm: true),
          const Gap(30),
          _buildRegisterButton(),
          const Gap(30),
          _buildSignInText(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'SIGN UP',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.teal,
          ),
        ),
        Text(
          'Create your new account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label, icon),
      validator: validator,
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label,
      {bool isConfirm = false}) {
    return Obx(() => TextFormField(
          controller: controller,
          obscureText: !ctForm.isPasswordVisible,
          decoration: _inputDecoration(
            label,
            Icons.lock,
            isPassword: true,
          ),
          validator: isConfirm
              ? (value) => validateConfirmPassword(value, _password.text)
              : validatePassword,
        ));
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: register,
      style: _buttonStyle(),
      child: const Text(
        'Register',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?',
            style: TextStyle(color: Colors.teal)),
        TextButton(
          onPressed: () => Get.toNamed(Routes.getLoginPage),
          child: const Text(
            'Log in',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: CustomColors.light.normal,
      padding: const EdgeInsets.all(20),
      elevation: 3,
      backgroundColor: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon,
      {bool isPassword = false}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal),
      ),
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.teal),
      suffixIcon: isPassword
          ? Obx(() => IconButton(
                icon: Icon(
                  ctForm.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                color: Colors.teal,
                onPressed: ctForm.togglePasswordVisibility,
              ))
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.teal),
      ),
    );
  }
}
