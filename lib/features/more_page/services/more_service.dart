import 'package:flutter/material.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';
import 'package:weather_app/routes/app_routes.dart';

class MoreService {
  void navigateWithAuth({
    required BuildContext context,
    required AuthState authState,
    required String targetRoute,
  }) {
    if (authState is AuthSuccess) {
      Navigator.pushNamed(context, targetRoute);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please login to access this feature!"),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }
}