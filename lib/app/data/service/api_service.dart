import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

class ApiService {
  final String baseUrl = AppConfig.baseUrl;
  String? token;

  // REGISTER USER (Tanpa nomorHp)
  Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nama": nama,
          "email": email,
          "password": password,
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("Gagal menghubungi server: $e");
    }
  }

  // LOGIN USER
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      final result = await _handleResponse(response);
      token = result['access_token'];
      return result;
    } catch (e) {
      throw Exception("Login gagal: $e");
    }
  }

  // GET PROFILE USER
  Future<Map<String, dynamic>> getProfile() async {
    if (token == null)
      throw Exception("Token belum tersedia. Login terlebih dahulu.");
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("Gagal mengambil profil: $e");
    }
  }

  // UPDATE PROFILE USER (password opsional)
  Future<Map<String, dynamic>> updateProfile({
    required String nama,
    required String email,
    required String nomorHp,
    String? password,
  }) async {
    if (token == null)
      throw Exception("Token belum tersedia. Login terlebih dahulu.");

    final Map<String, dynamic> body = {
      "nama": nama,
      "email": email,
      "nomor_hp": nomorHp,
    };

    if (password != null && password.isNotEmpty) {
      body["password"] = password;
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update_account'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("Gagal memperbarui profil: $e");
    }
  }

  // HANDLE RESPONSE
  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      final message = data['message'] ?? 'Terjadi kesalahan';
      throw Exception(message);
    }
  }
}
