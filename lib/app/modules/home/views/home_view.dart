import 'package:book_list/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(''),
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Image.asset('assets/icons/menu.png', width: 30),
                ),
              ],
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        clipBehavior: Clip.none,
        backgroundColor: Color(0xFF1A1A1A),
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: 40),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book List',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          'Member',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Color(0xFFFF7622)),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              selected: true,
              splashColor: Color(0xFFFF7622),
              selectedColor: Color(0xFFFF7622),
              onTap: () => Get.offAllNamed(Routes.HOME),
            ),
            ListTile(
              leading: Icon(Icons.history, size: 22, color: Colors.white),
              title: Text(
                'History Borrowing',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, size: 20, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () => controller.logout(),
            ),
          ],
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notif) {
          if (notif.metrics.pixels <= 0 && notif is OverscrollNotification) {
            controller.refreshAll();
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mt(20),
                RichText(
                  text: TextSpan(
                    text: 'Hey Gabrial, ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: 'Good Afternoon !',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                mt(20),
                Container(
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      mh(10),
                      Text(
                        'Search dishes, restaurants',
                        style: TextStyle(
                          color: Colors.white60,
                          fontFamily: 'Poppins',
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),

                mt(30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'All Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                mt(20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [categoryList(controller)]),
                ),

                mt(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                mt(20),
                Container(
                  width: double.infinity,
                  child: Obx(() {
                    return Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: controller.books.map((item) {
                        return book(item);
                      }).toList(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget mt(double angka) => SizedBox(height: angka);
Widget mh(double angka) => SizedBox(width: angka);

Widget categoryList(HomeController controller) {
  return Obx(() {
    return Row(
      children: controller.category.map((item) {
        return GestureDetector(
          onTap: () {
            controller.selectedCategory.value = item['name'];
            controller.fetchBook(category: item['name']);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.only(bottom: 10, right: 10),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: controller.selectedCategory.value == item['name']
                    ? Color(0xFFFF7622)
                    : Color(0xFF1A1A1A),
                width: 1,
              ),
            ),
            child: Text(
              item['name'],
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  });
}

Widget book(Map<String, dynamic> item) {
  return InkWell(
    onTap: () {
      Get.toNamed(Routes.BOOK_DETAIL, arguments: item['id']);
    },
    child: Container(
      width: 178,
      height: 290,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: "http://192.168.10.37:8000${item['image']}",
              width: double.infinity,
              height: 215,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 215,
                color: Colors.grey.shade900,
              ),
              errorWidget: (context, url, error) => Container(
                width: double.infinity,
                height: 215,
                color: Colors.grey.shade900,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  item['author'],
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                  ),
                ),
                Text(
                  "Stock: ${item['available_stock']}",
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
