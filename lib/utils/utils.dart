import 'package:get/get.dart';

class Utils {
  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }
}
