import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookManagementController extends GetxController {
  //TODO: Implement BookManagementController
  var books = [].obs;
  final count = 0.obs;
  var category = <Map<String, dynamic>>[].obs;
  var selectedCategory = Rxn<String>();
  @override
  void onInit() {
    super.onInit();
    fetchBook();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token') ?? 'monyet';
      print('Token: $token');
      var url = Uri.parse("http://192.168.10.37:8000/api/v1/book-categories");
      var response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        category.value = List<Map<String, dynamic>>.from(data);
        print('Category: $category');
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch categories",
          backgroundColor: Colors.white,
        );
        print('Token: $token');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchBook({String? category}) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token') ?? 'monyet';

      String baseUrl = "http://192.168.10.37:8000/api/v1/books";

      var url = category != null && category.isNotEmpty
          ? Uri.parse("$baseUrl?category=$category")
          : Uri.parse(baseUrl);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        books.value = List<Map<String, dynamic>>.from(data['data']);
      } else {
        Get.snackbar("Error", "Failed to fetch books");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
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
