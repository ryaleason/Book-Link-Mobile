import 'package:book_list/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? roleId = prefs.getInt('role_id');
    bool isLogin = prefs.getBool('isRemember') ?? false;
    String? token = prefs.getString('token');

    Future.delayed(const Duration(seconds: 2), () {
      if (token == null) {
        return Get.offAllNamed(Routes.LOGIN);
      }

      if (roleId == 1 || roleId == 2) {
        return Get.offAllNamed(Routes.DASHBOARD);
      }
      return Get.offAllNamed(Routes.HOME);
    });
  }
}
