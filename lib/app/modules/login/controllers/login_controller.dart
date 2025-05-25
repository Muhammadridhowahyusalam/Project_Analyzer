import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_analyzer/app/data/service/api_service.dart';
import 'package:snack_analyzer/app/data/service/oauth_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  final GoogleAuthService googleAuthService = GoogleAuthService();

  void login(String email, String password) async {
    try {
      final response = await apiService.login(email: email, password: password);
      final token = response['access_token'];
      final user = response['user'];
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', token);
      await prefs.setString('nama', user['nama']);
      await prefs.setString('email', user['email']);

      Get.offAllNamed(Routes.HOME);
      Get.snackbar("Login Berhasil", "Selamat datang ${user['nama']}");
    } catch (e) {
      Get.snackbar("Login Gagal", e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final result = await googleAuthService.signInAndAuthenticate();

      if (result == null || result['success'] == false) {
        final message = result?['message'] ?? 'Gagal login dengan Google';
        Get.snackbar("Login Gagal", message);
        return;
      }

      final data = result['data'];
      final token = data['access_token'];
      final user = data['user'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('nama', user['nama']);
      await prefs.setString('email', user['email']);

      Get.offAllNamed(Routes.HOME);
      Get.snackbar("Login Berhasil", "Selamat datang ${user['nama']}");
    } catch (e) {
      print("Google login error: $e");
      Get.snackbar("Login Gagal", "Terjadi kesalahan saat login dengan Google");
    }
  }
}
