import 'package:get/get.dart';

import '../controllers/history_borrowing_controller.dart';

class HistoryBorrowingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryBorrowingController>(
      () => HistoryBorrowingController(),
    );
  }
}
