// features/home/data/home_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/model/models.dart';



class HomeService {
  final String _weatherApiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
  final String _aqiToken = dotenv.env['AQI_TOKEN'] ?? '';

  Future<List<WeatherForecastModel>> fetchHomeData(String city) async {
    final weatherUrl = Uri.parse("https://api.weatherapi.com/v1/forecast.json?key=$_weatherApiKey&q=$city&days=7&aqi=no");
    final aqiUrl = Uri.parse("https://api.waqi.info/feed/$city/?token=$_aqiToken");

    try {
      final responses = await Future.wait([
        http.get(weatherUrl),
        http.get(aqiUrl),
      ]);
          debugPrint('Response Status Code: ${responses[0].statusCode}');
          debugPrint('Response Status Code: ${responses[1].statusCode}');
      if (responses[0].statusCode == 200 && responses[1].statusCode == 200) {
        final weatherData = jsonDecode(responses[0].body);
        final aqiData = jsonDecode(responses[1].body);

        final int currentCityAqi = aqiData['data']['aqi'] ?? 0;
        final List forecastDays = weatherData['forecast']['forecastday'];

        return forecastDays.map((dayData) {
          return WeatherForecastModel(
            forecastDate: DateTime.parse(dayData['date']),
            maxTemp: (dayData['day']['maxtemp_c'] as num).toDouble(),
            minTemp: (dayData['day']['mintemp_c'] as num).toDouble(),
            condition: dayData['day']['condition']['text'].toString(),
            aqi: currentCityAqi,
          );
        }).toList();
      } else {
        throw Exception("Failed to load data from APIs");
      }
    } catch (e) {
      rethrow;
    }
  }
}