import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_forecast_model.dart';

class WeatherDailyCard extends StatelessWidget {
  final WeatherForecastModel forecast;

  const WeatherDailyCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    String day = DateFormat('E').format(forecast.forecastDate);

    IconData aqiIcon = Icons.sentiment_satisfied_alt;
    Color aqiColor = Colors.green;
    final currentAQI = forecast.aqi ?? 0;

    if (currentAQI > 100) {
      aqiIcon = Icons.sentiment_very_dissatisfied;
      aqiColor = Colors.red;
    } else if (currentAQI > 50) {
      aqiIcon = Icons.sentiment_neutral;
      aqiColor = Colors.orange;
    }

    IconData weatherIcon = Icons.wb_sunny;
    Color weatherIconColor = Colors.orange;
    final condition = forecast.condition?.toLowerCase() ?? '';

    if (condition.contains('rain') || condition.contains('shower')) {
      weatherIcon = Icons.umbrella;
      weatherIconColor = Colors.blue;
    } else if (condition.contains('cloud') || condition.contains('overcast')) {
      weatherIcon = Icons.cloud;
      weatherIconColor = Colors.grey;
    } else if (condition.contains('snow')) {
      weatherIcon = Icons.ac_unit;
      weatherIconColor = Colors.lightBlueAccent;
    }

    return Container(
      width: 70,
      padding: EdgeInsets.only(bottom: 5, top: 5),
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 232, 239, 232),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "SF Pro Display",
            ),
          ),

          Icon(aqiIcon, color: aqiColor),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${forecast.aqi ?? '-'}",
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "AQI",
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),

          Icon(weatherIcon, color: weatherIconColor),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${forecast.maxTemp ?? '__'}",
                style: TextStyle(
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "°C",
                style: TextStyle(
                  fontFamily: "ABeeZee",
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
