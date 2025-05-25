import 'package:get/get.dart';

import '../controllers/otp_verifkasi_controller.dart';

class OtpVerifkasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerifkasiController>(
      () => OtpVerifkasiController(),
    );
  }
}
