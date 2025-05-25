import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:snack_analyzer/app/data/service/config.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '1021492942163-cn7a9ftdo0hk034kk20pui78k7d0kct7.apps.googleusercontent.com', // ganti ke client ID kamu
  );

  Future<Map<String, dynamic>?> signInAndAuthenticate() async {
    try {
      await _googleSignIn.signOut(); // Optional: force fresh login
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      if (auth?.idToken == null) return null;

      final url = Uri.parse('${AppConfig.baseUrl}/auth/google');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': auth!.idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
