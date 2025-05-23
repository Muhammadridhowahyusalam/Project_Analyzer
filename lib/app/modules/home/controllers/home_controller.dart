import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
  }

  void loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('nama') ?? 'User';
  }
}
