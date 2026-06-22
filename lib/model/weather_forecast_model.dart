// features/home/data/models/weather_forecast_model.dart
class WeatherForecastModel {
  final DateTime forecastDate;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final int aqi;

  WeatherForecastModel({
    required this.forecastDate,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.aqi,
  });
}