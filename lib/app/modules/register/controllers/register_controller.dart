import 'package:get/get.dart';
import 'package:snack_analyzer/app/data/service/api_service.dart';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final ApiService apiService = ApiService();

  void register(String nama, String email, String password) async {
    try {
      final result = await apiService.register(
          nama: nama, email: email, password: password);

      final message =
          result['message'] ?? 'Registrasi berhasil, silakan login.';
      Get.snackbar("Berhasil", message);

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar(
        "Registrasi Gagal",
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
