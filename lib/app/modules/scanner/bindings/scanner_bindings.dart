import 'package:get/get.dart';
import 'package:snack_analyzer/app/modules/scanner/controllers/scanner_controllers.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(() => ScannerController());
  }
}
