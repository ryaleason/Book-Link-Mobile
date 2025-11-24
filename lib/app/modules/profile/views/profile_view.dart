import 'package:book_list/app/modules/login/views/login_view.dart';
import 'package:book_list/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        scrolledUnderElevation: 0,
        title: const Text(''),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 224,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1120),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      77,
                      77,
                      77,
                    ).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset('assets/images/profile.jpeg'),
            ),
            SizedBox(height: 16),

            Text(
              'Ryaleason',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),

            mt(16),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  // Action for edit profile button
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: const Color.fromARGB(255, 128, 128, 128),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 32),
            menu(Icons.history, 'History Borrowing', Routes.HISTORY_BORROWING),
            mt(16),
            menu(Icons.shopping_cart, 'Cart List', Routes.CART),
            mt(16),
            menu(Icons.favorite, 'Favorite List', Routes.CART),
            mt(16),

            ElevatedButton(
              onPressed: () {
                controller.logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
            mt(16),
          ],
        ),
      ),
    );
  }
}

Widget menu(IconData icon, String title, String routes) {
  return InkWell(
    onTap: () {
      Get.toNamed(routes);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 29, 29, 29),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
