import 'package:get/get.dart';
import 'package:snack_analyzer/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:snack_analyzer/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:snack_analyzer/app/modules/informasi/bindings/informasi_binding.dart';
import 'package:snack_analyzer/app/modules/informasi/views/informasi_view.dart';
import 'package:snack_analyzer/app/modules/informasi/views/informasi_detail_view.dart';

import '../modules/grafik/bindings/grafik_binding.dart';
import '../modules/grafik/views/grafik_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/scanner/bindings/scanner_bindings.dart';
import '../modules/scanner/views/scanner_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.SCANNER,
      page: () => ScannerView(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: Routes.GRAFIK,
      page: () => const GrafikView(),
      binding: GrafikBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.INFORMASI,
      page: () => const InformasiView(),
      binding: InformasiBinding(),
    ),
    GetPage(
      name: Routes.INFORMASI_DETAIL,
      page: () => InformasiDetailView(informasi: Get.arguments),
    ),
  ];
}
