import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: "BOOK LIST",
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
