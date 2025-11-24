import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  //TODO: Implement CartController

  final count = 0.obs;
  var cart = [].obs;
  late String token;
  @override
  void onInit() {
    super.onInit();
    fetchBook();
  }

  Future<void> delete(int bookId) async {
    var presh = await SharedPreferences.getInstance();
    token = presh.getString('token') ?? 'monyet';
    var url = Uri.parse('http://192.168.10.37:8000/api/v1/book-carts/$bookId');
    var response = await http.delete(
      url,
      headers: {
        'Authorization': "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200) {
      fetchBook();
      Get.snackbar(
        'Berhasil',
        "Berhasil Menghapus buku",
        backgroundColor: Colors.white,
      );
    } else {
      print(response.statusCode);
      print(response.body);
      print(bookId);
    }
  }

  void tambah(int bookId) {
    int index = cart.indexWhere((e) => e['book_id'] == bookId);

    if (index == -1) return;

    cart[index]['qty']++;
    cart.refresh();
  }

  void kurang(int bookId) {
    int index = cart.indexWhere((e) => e['book_id'] == bookId);

    if (index == -1) return;

    if (cart[index]['qty'] > 1) {
      cart[index]['qty']--;
    }

    cart.refresh();
  }

  Future<void> fetchBook() async {
    var presh = await SharedPreferences.getInstance();
    token = presh.getString('token') ?? 'monyet';
    var url = Uri.parse('http://192.168.10.37:8000/api/v1/book-carts');
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
      cart.value = List<Map<String, dynamic>>.from(data['data']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> borrow() async {
    var url = Uri.parse("http://192.168.10.37:8000/api/v1/book-loans");
    var response = await http.post(
      url,
      headers: {
        'Authorization': "Bearer $token",
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'books': cart
            .map((e) => {'id': e['book_id'], 'qty': e['qty']})
            .toList(),
      }),
    );
    if (response.statusCode == 200) {
      fetchBook();
      Get.snackbar(
        'Berhasil',
        "Berhasil Meminjam buku",
        backgroundColor: Colors.white,
      );
    } else {
      var data = jsonDecode(response.body);
      Get.snackbar('Berhasil', data["message"], backgroundColor: Colors.white);
      print(response.statusCode);
      print(response.body);
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
