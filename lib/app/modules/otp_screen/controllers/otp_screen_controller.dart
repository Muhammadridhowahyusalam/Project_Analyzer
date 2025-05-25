import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OtpController extends GetxController {
  final otpCode = ''.obs;
  final TextEditingController otpTextController = TextEditingController();

  void onOtpChanged(String value) {
    otpCode.value = value;
  }

  void verifyOtp() {
    if (otpCode.value.length == 6) {
      // Validasi ke server atau logic verifikasi
      Get.snackbar("Sukses", "Kode OTP berhasil diverifikasi");
    } else {
      Get.snackbar("Error", "Kode OTP harus 6 digit");
    }
  }

  @override
  void onClose() {
    otpTextController.dispose();
    super.onClose();
  }
}