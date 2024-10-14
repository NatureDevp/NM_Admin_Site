import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../../api/api_auth.dart';
import '../../controllers/ct_form.dart';
import '../../controllers/ct_login.dart';
import '../../models/md_auth.dart';
import '../../utils/_colors.dart';
import '../../utils/_local_storage.dart';
import '../../utils/_routes.dart';
import '../../validators/vt_forms.dart';

class LoginPage extends GetView<LoginPageController> {
  LoginPage({super.key});

  //
  final FormController ctForm = Get.find<FormController>();

  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void _login() async {
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
          color: CustomColors.dark.normal,
        ));
      },
    );

    try {
      //
      var results = await APIAuth.login(Authorization(
        email: _emailControl.text,
        password: _passControl.text,
      ));

      Navigator.pop(Get.context!);

      if (results == null ||
          results['success'] == false ||
          results['data'] == null) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Login failed!',
          text: results!['message'],
          confirmBtnText: 'Ok',
          confirmBtnColor: CustomColors.error.normal,
          onConfirmBtnTap: () {
            Navigator.of(Get.context!).pop();
          },
        );
        return;
      }

      var auth = Authorization.fromJson(
        results['data'][0],
        results['access_token'],
      );

      // Show success message
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: 'Login Successful',
        text: 'Welcome ${auth.firstName} ${auth.lastName}!',
        confirmBtnText: 'Continue',
        confirmBtnColor: CustomColors.primary.normal,
        onConfirmBtnTap: () async {
          Navigator.of(Get.context!).pop();
          await saveSessionToken(auth.accessToken!);
          Get.offAllNamed(Routes.getHomePage, arguments: auth);
        },
      );
    } catch (error) {
      log(error.toString(), name: 'Login');
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.warning,
        title: 'Login failed!',
        text: 'Something went wrong. Please try again.',
        confirmBtnText: 'Ok',
        confirmBtnColor: CustomColors.error.normal,
        onConfirmBtnTap: () {
          Navigator.of(Get.context!).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.setWindowTitle('NatureMedix|Login');

    //
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child: Column(
            children: [
              _buildHeader(),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(Get.context!).size.height * 0.15,
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
      child: const Center(
        child: Text(
          'NATUREMEDIX ADMIN LOGIN',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(20),
          _buildTitle(),
          const Gap(30),
          _buildEmailField(),
          const Gap(20),
          _buildPasswordField(),
          const Gap(10),
          _buildForgotPasswordButton(),
          const Gap(20),
          _buildLoginButton(),
          const Gap(30),
          _buildSignUpPrompt(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'LOGIN',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.teal,
          ),
        ),
        Text(
          'Access your account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailControl,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.teal),
        ),
      ),
      validator: validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextFormField(
          controller: _passControl,
          obscureText: !ctForm.isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock, color: Colors.teal),
            suffixIcon: IconButton(
              icon: Icon(ctForm.isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off),
              color: Colors.teal,
              onPressed: ctForm.togglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.teal),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required. Please enter a password';
            }
            return null;
          },
        ));
  }

  Widget _buildForgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(color: Colors.teal),
        ),
        TextButton(
          onPressed: () => Get.toNamed(Routes.getSignupPage),
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
