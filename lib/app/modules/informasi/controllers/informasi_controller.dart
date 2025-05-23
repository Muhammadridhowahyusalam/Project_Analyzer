import 'package:get/get.dart';
import 'package:snack_analyzer/app/data/service/informasi_service.dart';
import '../../../models/informasi_model.dart';

class InformasiController extends GetxController {
  var informasiList = <InformasiModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInformasi();
  }

  void fetchInformasi() async {
    try {
      isLoading.value = true;
      final data = await InformasiService.fetchInformasi();
      print("Data didapat: ${data.length}");
      informasiList.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
