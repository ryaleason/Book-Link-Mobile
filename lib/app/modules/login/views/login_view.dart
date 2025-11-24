import 'package:book_list/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.black, // background
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mt(120),
                    Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    mt(6),
                    Text(
                      'Please sign in to your existing account',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),

                    mt(90),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
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
                          mt(10),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                        value: controller.Checkboxvalue.value,
                                        onChanged: (value) {
                                          controller.Checkboxvalue.value =
                                              value!;
                                        },
                                        checkColor: Colors.white,
                                        activeColor: Color(0xffFF7622),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.Checkboxvalue.value =
                                            !controller.Checkboxvalue.value;
                                      },
                                      child: Text(
                                        "Remember me",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xffFF7622),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
                                controller.login();
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
                          mt(20),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account?  ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),

                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: Color(0xffFF7622),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.REGISTER);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          mt(20),
                          Center(
                            child: Text(
                              'Or',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          mt(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Image.asset(
                                  'assets/icons/google.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Image.asset(
                                  'assets/icons/github.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ],
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
    );
  }
}

Widget mt(double angka) => SizedBox(height: angka);
Widget mh(double angka) => SizedBox(width: angka);
