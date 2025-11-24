import 'dart:convert';

import 'package:book_list/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  var Checkboxvalue = false.obs;
  var hidden_password = true.obs;
  var email = ''.obs;
  var name = ''.obs;
  var password = ''.obs;
  var configmpassword = ''.obs;

  final count = 0.obs;
  @override
  Future<void> register() async {
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        configmpassword.isEmpty) {
      Get.snackbar(
        'Gagal',
        'Semua field harus diisi',
        backgroundColor: Colors.white,
      );
      return;
    }

    if (password != configmpassword) {
      Get.snackbar(
        'Gagal',
        'Password tidak cocok',
        backgroundColor: Colors.white,
      );
      return;
    }

    var url = Uri.parse('http://192.168.10.37:8000/api/v1/register');
    var response = await http.post(
      url,
      body: {
        'name': name.value,
        'email': email.value,
        'password': password.value,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Get.snackbar("Sukses", data["message"], backgroundColor: Colors.white);
     
      Get.offAllNamed(Routes.LOGIN);
    } else {
      var data = jsonDecode(response.body);
      Get.snackbar("Gagal", data["message"] ?? "Terjadi kesalahan", backgroundColor: Colors.white);
    }
  }

  void onInit() {
    super.onInit();
  }

  void togglePassword() {
    hidden_password.value = !hidden_password.value;
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
