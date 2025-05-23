import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_analyzer/app/data/service/api_service.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/tema/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;

  // Inisialisasi ApiService dan ambil token
  final token =
      prefs.getString('token'); // jika token disimpan di SharedPreferences
  final apiService = ApiService();
  apiService.token = token; // Menetapkan token ke ApiService

  // Masukkan ApiService ke GetX
  Get.put<ApiService>(apiService);

  // Masukkan ThemeController ke GetX
  final themeController = Get.put(ThemeController());

  runApp(SnackAnalyzerApp(themeController));
}

class SnackAnalyzerApp extends StatelessWidget {
  final ThemeController themeController;

  SnackAnalyzerApp(this.themeController);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: "Snack Analyzer",
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ));
  }
}
