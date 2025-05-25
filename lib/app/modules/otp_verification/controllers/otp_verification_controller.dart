import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_analyzer/app/data/service/otp_service.dart';

class OtpVerificationController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;

  final String email = (Get.arguments as Map<String, dynamic>?)?['email'] ?? '';

  void verifyOtp() async {
    final otp = otpController.text.trim();

    if (otp.length != 6) {
      Get.snackbar("Error", "Kode OTP harus terdiri dari 6 digit.");
      return;
    }

    isLoading.value = true;

    try {
      final result = await OtpService.verifyOtp(email, otp);
      final status = result['status'];
      final message = result['message'];

      if (status == 200) {
        Get.snackbar("Sukses", message);
        // Arahkan ke halaman berikutnya, misal:
        Get.offAllNamed('/login');
      } else {
        Get.snackbar("Gagal", message);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan saat memverifikasi OTP.");
    } finally {
      isLoading.value = false;
    }
  }

  void resendOtp() {
    Get.snackbar("Info", "Kode OTP telah dikirim ulang."); // logika menyusul
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
