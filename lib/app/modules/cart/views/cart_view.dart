import 'package:book_list/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cart List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Column(
                  children: controller.cart.map((item) {
                    var count = item['qty'];
                    return bookcart(item, count, controller);
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            controller.borrow();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Borrow All',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Widget bookcart(Map<String, dynamic> item, count, CartController controller) {
  return InkWell(
    splashColor: Colors.black,
    highlightColor: Colors.black,
    onTap: () {
      Get.toNamed(Routes.BOOK_DETAIL, arguments: item['books']['id']);
    },
    child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 22, 22),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 200,
                child: Image.network(
                  "http://192.168.10.37:8000/storage/${item['books']['image']}",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['books']['title'],

                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    "By : ${item['books']['author']}",

                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['books']['publisher'],
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['books']['year_published'].toString(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 60),

                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 45,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.kurang(item['book_id']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(
                              color: Colors.grey[800]!,
                              width: 1,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 45,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            // controller.kurang();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(
                              color: Colors.grey[800]!,
                              width: 1,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 45,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.tambah(item['book_id']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(
                              color: Colors.grey[800]!,
                              width: 1,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          right: 10,
          top: 10,
          child: IconButton(
            onPressed: () {
              controller.delete(item['book_id']);
            },
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
