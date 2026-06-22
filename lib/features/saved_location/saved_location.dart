import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/home/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/bloc/weather_state.dart';
import 'package:weather_app/features/home/views/widget/saved_location_card.dart';


class SavedLocationsPage extends StatelessWidget {
  const SavedLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Saved Locations",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, weatherState) {
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

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
              
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 16),
                  child: Text(
                    "MONITORED PLACES",
                    style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

              
                SavedLocationCard(
                  place: "Work",
                  address: "Da Nang",
                  aqi: currentAQI,
                  temperature: minTemp,
                  condition: currentCondition,
                ),
                
                const SizedBox(height: 16),

              
                SavedLocationCard(
                  place: "Home",
                  address: "Da Nang",
                  aqi: currentAQI,
                  temperature: maxTemp,
                  condition: currentCondition,
                ),
                
                const SizedBox(height: 25),
                
              
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                  
                  },
                  icon: const Icon(Icons.add_location_alt_rounded, size: 18),
                  label: const Text(
                    "Add New Location",
                    style: TextStyle(fontFamily: "SF Pro Display", fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}