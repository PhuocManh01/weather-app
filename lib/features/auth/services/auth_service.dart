import 'package:flutter/foundation.dart';

import '../../../core/storage/auth_local_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = "https://api.escuelajs.co/api/v1/auth";


  Future<bool> login(String username, String password, bool isRememberMe) async {
  final url = Uri.parse("$_baseUrl/login");
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": "$username@mail.com", 
        "password": password,
      }),
    ).timeout(const Duration(seconds: 5));

    debugPrint('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final String accessToken = data['access_token'];
      final String refreshToken = data['refresh_token'];

      await AuthLocalStorage.saveToken(accessToken, refreshToken);
      await AuthLocalStorage.saveLoginCredentials(
        rememberMeFlag: isRememberMe, 
        username: username, 
        password: password
      );
      return true;
    }
    return false;
  } catch (e, stackTrace) {
    debugPrint("Exception: $e");
    debugPrint(stackTrace as String?);
    rethrow;
  }
}

  Future <bool> isLogined() async {
    final token = AuthLocalStorage.getToken();
    final expiryTime = AuthLocalStorage.getExpiryTime();
    if (token == null || token.isEmpty || expiryTime == null) {
      return false;
    }
    if (DateTime.now().isAfter(DateTime.parse(expiryTime))) {
      return false;
    }
    return true;
  }

  Future <void> logout() async {
    AuthLocalStorage.clearToken();
  }
  
}
