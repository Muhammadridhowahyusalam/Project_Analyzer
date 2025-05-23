import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/informasi_model.dart';

class InformasiService {
  static const String _baseUrl =
      'http://10.0.2.2:5000'; // Untuk Android emulator

  static Future<List<InformasiModel>> fetchInformasi() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/informasi'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => InformasiModel.fromJson(item)).toList();
      } else {
        throw Exception(
            'Gagal memuat data informasi. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
