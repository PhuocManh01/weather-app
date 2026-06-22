import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/routes/app_routes.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';

import 'widget/weather_main_card.dart';
import 'widget/saved_location_card.dart';
import '../../more_page/views/widget/menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getBackgroundImage(String condition) {
    final condLower = condition.toLowerCase();
    final hour = DateTime.now().hour;

    if (hour >= 19 || hour < 6) {
      return 'assets/images/home/night.jpg';
    }

    if (condLower.contains('rain') || condLower.contains('shower') || condLower.contains('drizzle') || condLower.contains('thunderstorm')) {
      return 'aassets/images/home/rainy.jpg';
    }

    if (hour >= 16 && hour < 19) {
      return 'assassets/images/home/sunset.jpg';
    }

    if (condLower.contains('cloud') || condLower.contains('overcast') || condLower.contains('mist') || condLower.contains('fog')) {
      return 'assets/images/home/cloud.jpg';
    }

    return 'assets/images/home/sunny.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        
        String backgroundImage = 'assets/images/home/sunny.jpg';

        if (weatherState is WeatherSuccess && weatherState.forecasts.isNotEmpty) {
          backgroundImage = _getBackgroundImage(weatherState.forecasts.first.condition);
        }

        return Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withAlpha(100),
                  BlendMode.darken,
                ),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      const SizedBox(height: 10),

                      
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                          String titleText = "Welcome";
                          Widget trailingWidget = TextButton(
                            
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.green), 
                            ),
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          );
                          
                          if (authState is AuthSuccess) {
                            titleText = "Welcome back,";
                            trailingWidget = Text(
                              authState.username,
                              style: const TextStyle(
                                color: Colors.blueAccent, 
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: "SF Pro Display",
                              ),
                              overflow: TextOverflow.ellipsis,
                            );
                          }

                          return Row(
                            children: [
                              Text(
                                titleText,
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: "ABeeZee",
                                ),
                              ),
                              const Spacer(),
                              trailingWidget,
                              const SizedBox(width: 10),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      
                      if (weatherState is WeatherLoading)
                        const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator(color: Colors.green)),
                        )
                      else if (weatherState is WeatherFailure)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(weatherState.message, style: const TextStyle(color: Colors.red)),
                        )
                      else if (weatherState is WeatherSuccess)
                        WeatherMainCard(forecasts: weatherState.forecasts, locationName: "Da Nang")
                      else
                        const WeatherMainCard(forecasts: [], locationName: ""),

                      const SizedBox(height: 10),

                      
                      Builder(
                        builder: (context) {
                          int currentAQI = 0;
                          double minTemp = 0.0;
                          double maxTemp = 0.0;
                          String currentCondition = "Clear";

                          if (weatherState is WeatherSuccess && weatherState.forecasts.isNotEmpty) {
                            final todayWeather = weatherState.forecasts.first;
                            currentAQI = todayWeather.aqi;
                            minTemp = todayWeather.minTemp;
                            maxTemp = todayWeather.maxTemp;
                            currentCondition = todayWeather.condition;
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  SavedLocationCard(
                                    place: "Work",
                                    address: "Da Nang",
                                    aqi: currentAQI,
                                    temperature: minTemp,
                                    condition: currentCondition,
                                  ),
                                  const SizedBox(width: 20),
                                  SavedLocationCard(
                                    place: "Home",
                                    address: "Da Nang",
                                    aqi: currentAQI,
                                    temperature: maxTemp,
                                    condition: currentCondition,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              
                      const SizedBox(height: 10),
                      
                      
                      MenuButton(
                        iconButton: Icons.info,
                        nameButton: "Detail Air Quality",
                        onTap: () => Navigator.pushNamed(context, AppRoutes.locationDetail),
                      ),

                      MenuButton(
                        iconButton: Icons.health_and_safety_outlined,
                        nameButton: "AQI Scale",
                        onTap: () => Navigator.pushNamed(context, AppRoutes.aqiScale),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}