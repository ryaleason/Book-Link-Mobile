import 'package:book_list/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_detail_controller.dart';

class BookDetailView extends GetView<BookDetailController> {
  const BookDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.bookdetail.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: Get.height * 0.55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "http://192.168.10.37:8000${controller.bookdetail['image']}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        Colors.black,
                      ],
                      stops: [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Scrollable Content
            SingleChildScrollView(
              child: SafeArea(
                bottom: false, // Jangan tambah padding bottom dari SafeArea
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),

                    SizedBox(height: Get.height * 0.35),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            controller.bookdetail['title'].toString(),
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          // Categories
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.category.map<Widget>((cat) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  cat['name'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12),

                          // Info Row
                          Row(
                            children: [
                              Text(
                                controller.bookdetail['year_published']
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[600]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'Available',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${controller.bookdetail['available_stock']} Stock',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '4.5 Ratings',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),

                          Text(
                            controller.bookdetail['description'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[300],
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 8),

                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'Read More',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Extra space untuk bottom buttons
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 120),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    top: BorderSide(color: Colors.grey[900]!, width: 1),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            width: 45,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.kurang();
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
                                size: 25,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            width: 45,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {},
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
                                '${controller.counted.value}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
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
                                controller.tambah();
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
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),

                      mt(12),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
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
                                  'Borrow Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          SizedBox(
                            width: 60,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.addtocard();
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
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          // Plus Button
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
