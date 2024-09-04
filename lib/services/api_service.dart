import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://10.0.2.2:3000/api/auth'; // Ubah sesuai IP lokal
  // 'https://poorly-willing-goblin.ngrok-free.app/api/auth'; // Ubah sesuai IP lokal, ini pake ngrok buat testing
  // 'https://profound-opossum-loudly.ngrok-free.app/api/auth'; // Ubah sesuai IP lokal, ini pake ngrok buat testing, punya widie
  // 'https://a5a0-103-106-114-224.ngrok-free.app/api/auth'; // Ubah sesuai IP lokal, ini pake ngrok buat testing, punya widie

  static Future<Map<String, dynamic>?> login(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return response body
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return {'error': responseBody['message'] ?? 'Unknown error occurred'};
    }
  }

  static Future<String?> register(String username, String email,
      String password, String confirmPassword, String namaLengkap) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'namaLengkap': namaLengkap, // Include namaLengkap in the request body
        }),
      );

      if (response.statusCode == 200) {
        return null; // Pendaftaran berhasil
      } else {
        // Coba parse sebagai JSON, jika gagal, kembalikan response body sebagai string
        try {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          return responseBody['message'] ?? 'Unknown error occurred';
        } catch (e) {
          return response.body; // Kembalikan response body sebagai string
        }
      }
    } catch (e) {
      return 'Failed to connect to server';
    }
  }
}
