import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var nama = 'Nama Pengguna'.obs;
  var email = 'user@email.com'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Fungsi untuk memuat data pengguna dari SharedPreferences
  Future<void> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      nama.value = prefs.getString('nama') ?? 'Nama Pengguna';
      email.value = prefs.getString('email') ?? 'user@email.com';
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  // Fungsi untuk menghapus data pengguna
  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print("Error clearing user data: $e");
    }
  }
}
