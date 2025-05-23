import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_analyzer/app/data/service/api_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();

  void login(String email, String password) async {
    try {
      final response = await apiService.login(email: email, password: password);
      final token = response['access_token'];
      final user = response['user'];
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', token);
      await prefs.setString('nama', user['nama']); // Simpan nama
      await prefs.setString(
          'email', user['email']); // Simpan email ← INI PENTING

      Get.offAllNamed(Routes.HOME);
      Get.snackbar("Login Berhasil", "Selamat datang ${user['nama']}");
    } catch (e) {
      Get.snackbar("Login Gagal", e.toString().replaceAll('Exception: ', ''));
    }
  }

  void loginWithGoogle() {
    print("Login dengan Google berhasil (simulasi)");
    Get.offAllNamed(Routes.HOME);
  }
}
