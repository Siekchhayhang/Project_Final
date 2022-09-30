import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }
}
