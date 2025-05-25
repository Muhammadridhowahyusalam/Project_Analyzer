import 'package:http/http.dart' as http;
import 'package:snack_analyzer/app/data/service/config.dart';
import 'dart:convert';

class OtpService {
  static Future<Map<String, dynamic>> verifyOtp(
      String email, String otp) async {
    final url = Uri.parse('${AppConfig.baseUrl}/verify-otp');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
    );

    final data = jsonDecode(response.body);
    return {
      'status': response.statusCode,
      'message': data['message'],
    };
  }
}
