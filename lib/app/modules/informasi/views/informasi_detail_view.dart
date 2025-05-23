import 'package:flutter/material.dart';
import '../../../models/informasi_model.dart';

class InformasiDetailView extends StatelessWidget {
  final InformasiModel informasi;

  const InformasiDetailView({super.key, required this.informasi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Informasi")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/${informasi.gambarNama}'),
            SizedBox(height: 16),
            Text(informasi.judul,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(informasi.deskripsiLengkap),
          ],
        ),
      ),
    );
  }
}
