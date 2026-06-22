import 'package:flutter/material.dart';
import 'app_routes.dart';

import '../features/bottom_navigation/views/bottom_navigation_screen.dart';
import '../features/onboarding/onboarding_building.dart';
import '../features/auth/views/login_page.dart';
import '../features/aqi_scale/aqi_scale.dart';
import '../features/location_detail/location_detail.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingBuilding());
      case AppRoutes.bottomNavigationScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavigationScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.aqiScale:
        return MaterialPageRoute(builder: (_) => const AQIScale());
      case AppRoutes.locationDetail:
        return MaterialPageRoute(builder: (_) => const LocationDetail());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text("The page does not exist!"))));
    }
  }
}