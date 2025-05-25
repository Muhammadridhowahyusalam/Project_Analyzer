import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snack_analyzer/app/data/service/api_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        // Simpan data lokal
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('nama', account.displayName ?? 'Guest');
        await prefs.setString('email', account.email);
        await prefs.setString(
            'token', 'google'); // Token placeholder (opsional)

        Get.offAllNamed(Routes.HOME);
        Get.snackbar("Login Berhasil", "Selamat datang ${account.displayName}");
      } else {
        Get.snackbar("Login Dibatalkan", "Anda membatalkan login Google");
      }
    } catch (e) {
      print("Google login error: $e");
      Get.snackbar("Login Gagal", "Google Sign-In gagal");
    }
  }
}
