import 'dart:convert';

import 'package:book_list/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  var Checkboxvalue = false.obs;
  var hidden_password = true.obs;

  var email = ''.obs;
  var password = ''.obs;

  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        backgroundColor: Colors.white,
      );
      return;
    }
    var url = Uri.parse("http://192.168.10.37:8000/api/v1/login");
    var response = await http.post(
      url,
      body: {'email': email.value, 'password': password.value},
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Get.snackbar("Sukses", data["message"], backgroundColor: Colors.white);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (Checkboxvalue.value == true) {
        prefs.setBool('isRemember', true);
      }
      prefs.setString('token', data['token']);
      int roleId = data['data']['role_id'];
      prefs.setInt('role_id', roleId);

      if (roleId == 1 || roleId == 2) {
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      var data = jsonDecode(response.body);
      Get.snackbar(
        "Login Failed",
        data["message"] ?? "Invalid credentials",
        backgroundColor: Colors.white,
      );
    }
  }

  @override
  void togglePassword() {
    hidden_password.value = !hidden_password.value;
  }

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
