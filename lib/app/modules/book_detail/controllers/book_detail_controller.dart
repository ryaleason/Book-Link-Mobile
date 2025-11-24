import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookDetailController extends GetxController {
  final count = 0.obs;
  var bookdetail = {}.obs;
  var category = [].obs;
  var counted = 0.obs;
  late int bookId;
  @override
  void onInit() async {
    super.onInit();
    bookId = Get.arguments;
    print("Received Book ID: $bookId");
    await fetchBookDetail();
  }

  void validasi() {
    if (counted.value == 0) {
      Get.snackbar(
        "Gagal",
        "Jumlah buku tidak boleh kosong",
        backgroundColor: Colors.white,
      );
    }
  }

  Future<void> fetchBookDetail() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token') ?? 'monyet';
      print('Token: $token');
      var url = Uri.parse("http://192.168.10.37:8000/api/v1/books/$bookId");
      var response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        bookdetail.value = data;
        category.value = data['categories'] ?? [];
        print('Book Detail: $category');
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch book details",
          backgroundColor: Colors.white,
        );
        print('Token: $token');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void borrow() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token') ?? 'monyet';
      print('Token: $token');
      var url = Uri.parse("http://192.168.10.37:8000/api/v1/book-loans");
      var response = await http.post(
        url,
        headers: {
          'Authorization': "Bearer $token",
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'books': [
            {'id': bookId, 'qty': counted.value},
          ],
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.snackbar("Sukses", data["message"], backgroundColor: Colors.white);
      } else if (response.statusCode == 422) {
        var data = jsonDecode(response.body);

        print("VALIDATION ERROR:");
        print(jsonEncode(data));

        data['errors'].forEach((key, value) {
          print("$key: $value");
        });
      } else {
        var data = jsonDecode(response.body);
        Get.snackbar("Gagal", data["message"], backgroundColor: Colors.white);
        print("ERROR ${response.statusCode}:");
        print(jsonEncode(data));
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void tambah() {
    counted.value++;
  }

  void kurang() {
    if (counted.value > 0) {
      counted.value--;
    }
  }

  Future<void> addtocard() async {
    var pres = await SharedPreferences.getInstance();
    var token = pres.getString('token') ?? 'monyet';

    var url = Uri.parse("http://192.168.10.37:8000/api/v1/book-carts");
    validasi();

    var response = await http.post(
      url,
      headers: {
        'Authorization': "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'book_id': bookId, 'qty': counted.value}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Get.snackbar("Sukses", data["message"], backgroundColor: Colors.white);
    } else {
      var data = jsonDecode(response.body);
      Get.snackbar("Gagal", data["message"], backgroundColor: Colors.white);
      print("ERROR ${response.statusCode}:");
      print(jsonEncode(data));
      print(bookId);
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
