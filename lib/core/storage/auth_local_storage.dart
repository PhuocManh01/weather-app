import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expiryTokenKey = 'expiry_token';
  static const String _rememberMeFlag = 'remember_me';
  // Vấn đề bảo mật: flutter_secure_storage thay cho shared_preferences
  static const String _savedUsername = 'username';
  static const String _savedPassword = 'password';

  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token, String refreshToken) async {
    await _sharedPreferences.setString(_tokenKey, token);
    await _sharedPreferences.setString(_refreshTokenKey, refreshToken);

    final expiryTime = DateTime.now().add(const Duration(hours: 10));
    await _sharedPreferences.setString(_expiryTokenKey, expiryTime.toIso8601String());
  }

  static Future<void> saveLoginCredentials({required bool rememberMeFlag, required String username, required String password}) async {
    await _sharedPreferences.setBool(_rememberMeFlag, rememberMeFlag);
    if (rememberMeFlag) {
      await _sharedPreferences.setString(_savedUsername, username);
      await _sharedPreferences.setString(_savedPassword, password);
    }
    else {
      await _sharedPreferences.remove(_savedUsername);
      await _sharedPreferences.remove(_savedPassword);
    }
  }

  static String? getExpiryTime() => _sharedPreferences.getString(_expiryTokenKey);
  static String? getRefreshToken() => _sharedPreferences.getString(_refreshTokenKey);
  static String? getToken() => _sharedPreferences.getString(_tokenKey);

  static bool getRememberMeFlag() => _sharedPreferences.getBool(_rememberMeFlag) ?? false;
  static String getUsername() => _sharedPreferences.getString(_savedUsername) ?? '';
  static String getPassword() => _sharedPreferences.getString(_savedPassword) ?? '';
  
  static Future<void> clearToken() async {
    await _sharedPreferences.remove(_tokenKey);
    await _sharedPreferences.remove(_refreshTokenKey);
    await _sharedPreferences.remove(_expiryTokenKey);
  }
}