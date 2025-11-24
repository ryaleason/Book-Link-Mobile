import 'package:book_list/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.black, // background
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      mt(50),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mt(6),
                      Text(
                        'Please sign up to get started',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),

                      mt(100),

                      Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.68,
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NAME",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            mt(10),

                            TextField(
                              onChanged: (value) =>
                                  controller.name.value = value,
                              onTap: () {},
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hint: Text("Example : Raja Langit"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            mt(20),

                            Text(
                              "EMAIL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            mt(10),

                            TextField(
                              onChanged: (value) =>
                                  controller.email.value = value,
                              onTap: () {},
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hint: Text("Example@gmail.com"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            mt(25),

                            Text(
                              "PASSWORD",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => TextField(
                                onChanged: (value) =>
                                    controller.password.value = value,
                                obscureText: controller.hidden_password.value,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),

                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.hidden_password.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      controller.togglePassword();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            mt(25),
                            Text(
                              "CONFIM PASSWORD",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => TextField(
                                onChanged: (value) =>
                                    controller.configmpassword.value = value,
                                obscureText: controller.hidden_password.value,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            mt(10),

                            mt(20),
                            Container(
                              width: double.infinity,
                              height: 65,
                              decoration: BoxDecoration(
                                color: Color(0xffFF7622),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF7622),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  controller.register();
                                },
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget mt(double angka) => SizedBox(height: angka);
Widget mh(double angka) => SizedBox(width: angka);
