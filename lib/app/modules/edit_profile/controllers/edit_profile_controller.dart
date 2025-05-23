import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack_analyzer/app/data/service/api_service.dart';

class EditProfileController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final nomorHpController = TextEditingController();
  final passwordController = TextEditingController(); // Tambah ini

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() async {
    try {
      isLoading.value = true;
      final data = await apiService.getProfile();
      namaController.text = data['nama'] ?? '';
      emailController.text = data['email'] ?? '';
      nomorHpController.text = data['nomor_hp'] ?? '';
      // passwordController tidak diisi, karena password tidak dikirim dari server
      passwordController.text = '';
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat profil");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      final result = await apiService.updateProfile(
        nama: namaController.text,
        email: emailController.text,
        nomorHp: nomorHpController.text,
        password: passwordController.text.isEmpty
            ? null
            : passwordController.text, // Kirim password jika tidak kosong
      );
      Get.snackbar("Berhasil", result["message"]);
      Get.back();
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
