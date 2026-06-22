import 'package:shared_preferences/shared_preferences.dart';

class AppSettingStorage {
  static late SharedPreferences _sharedPreferences;
  static const String _onboardingKey = "access_onboarding";

  static Future <void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool hasSeenOnboarding() => _sharedPreferences.getBool(_onboardingKey) ?? false;
  
  static Future <void> setHasSeenOnboarding() async{
    await _sharedPreferences.setBool(_onboardingKey, true);
  }

}