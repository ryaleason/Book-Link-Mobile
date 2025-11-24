import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
class HistoryBorrowingController extends GetxController {
  //TODO: Implement HistoryBorrowingController

  final count = 0.obs;
  late String token;
  var book = [].obs;
  var loanbook = [].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchBook();
  }

  Future<void> fetchBook() async {
  SharedPreferences share = await SharedPreferences.getInstance();
  token = share.getString('token') ?? 'monyet';

  var url = Uri.parse('http://192.168.10.37:8000/api/v1/book-loans');
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

    loanbook.value = List<Map<String, dynamic>>.from(data['data']);

    print("Loanbook: $loanbook");
  } else {
    var data = jsonDecode(response.body);
    Get.snackbar('Gagal', data['message'], backgroundColor: Colors.white);
  }
}

void delete(int loanid)async{
  if (loanid == 0) {
    Get.snackbar('Gagal', "Pilih Data Terlebih Dahulu", backgroundColor: Colors.white);
  }
  var url = Uri.parse('http://192.168.10.37:8000/api/v1/book-loans/$loanid');
  var response = await http.delete(
    url,
    headers: {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );
  fetchBook();
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
