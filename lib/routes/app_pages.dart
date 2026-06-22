import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/features/home/services/home_service.dart';
import 'package:weather_app/features/location_detail/bloc/location_detail_bloc.dart';
import 'package:weather_app/features/location_detail/bloc/location_detail_event.dart';
import 'package:weather_app/features/location_detail/services/weather_service.dart';

import 'package:weather_app/features/about_us/about_us.dart';
import 'package:weather_app/features/contact_us/contact_us.dart';
import 'package:weather_app/features/faq/faq.dart';
import 'package:weather_app/features/profile/profile.dart';
import 'package:weather_app/features/saved_location/saved_location.dart';
import 'app_routes.dart';

import '../features/bottom_navigation/views/bottom_navigation_screen.dart';
import '../features/onboarding/onboarding_building.dart';
import '../features/auth/views/login_page.dart';
import '../features/aqi_scale/aqi_scale.dart';
import '../features/location_detail/views/location_detail.dart';

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
        return MaterialPageRoute(builder: (_) => const AQIScalePage());
        
      case AppRoutes.locationDetail:
        final String cityName = settings.arguments is String 
            ? settings.arguments as String 
            : "Da Nang";

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => WeatherDetailBloc(
              homeService: HomeService(),
              weatherService: WeatherService(),
            )..add(FetchWeatherDetail(cityName)),
            child: const LocationDetail(),
          ),
        );
        
      case AppRoutes.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsPage());
      case AppRoutes.faq:
        return MaterialPageRoute(builder: (_) => const FaqPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      case AppRoutes.savedLocationPage:
        return MaterialPageRoute(builder: (_) => const SavedLocationsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("The page does not exist!")),
          ),
        );
    }
  }
}