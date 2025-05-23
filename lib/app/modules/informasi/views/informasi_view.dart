import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/informasi_controller.dart';
import 'informasi_detail_view.dart';

class InformasiView extends GetView<InformasiController> {
  const InformasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Informasi")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.informasiList.isEmpty) {
          return const Center(child: Text("Tidak ada informasi."));
        }

        return ListView.builder(
          itemCount: controller.informasiList.length,
          itemBuilder: (context, index) {
            final info = controller.informasiList[index];
            return GestureDetector(
              onTap: () => Get.to(() => InformasiDetailView(informasi: info)),
              child: Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/informasi/${info.gambarNama}',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        info.judul,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        info.deskripsiLengkap,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
