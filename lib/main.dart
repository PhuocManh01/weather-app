import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/data_bank_page/bloc/data_bank_bloc.dart';
import 'package:weather_app/features/home/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/bloc/weather_event.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'core/storage/auth_local_storage.dart';
import 'core/storage/app_setting_storage.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthLocalStorage.init();
  await AppSettingStorage.init();
  
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => DataBankBloc()),
        BlocProvider(create: (context) => AuthCubit()..checkAuthStatus()),
        BlocProvider(create: (context) => WeatherBloc()..add(FetchWeather("Da Nang")))
      ],
    child: const MyApp(),
    )
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String initialScreen = AppSettingStorage.hasSeenOnboarding()
        ? AppRoutes.bottomNavigationScreen
        : AppRoutes.onBoarding;

    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),

      debugShowCheckedModeBanner: false,

      title: 'Weather App',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      initialRoute: initialScreen,
      onGenerateRoute: AppPages.generateRoute,
    );
  }
}