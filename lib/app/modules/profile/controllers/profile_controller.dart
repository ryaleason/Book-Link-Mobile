import 'package:book_list/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isRemember') == true) {
      prefs.remove('isRemember');
      Get.offAllNamed(Routes.SPLASH_SCREEN);
    }
    Get.offAllNamed(Routes.SPLASH_SCREEN);
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
