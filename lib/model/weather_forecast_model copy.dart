import 'package:mongo_dart/mongo_dart.dart';

class WeatherForecastModel {
  final ObjectId? id;
  final ObjectId? cityId;
  final DateTime forecastDate;
  final double? minTemp;
  final double? maxTemp;
  final double? humidity;
  final double? windSpeed;
  final double? precipitationProbability;
  final String? condition;
  final int? aqi;
  final Map<String, dynamic>? extra;

  WeatherForecastModel({
    this.id,
    this.cityId,
    required this.forecastDate,
    this.minTemp,
    this.maxTemp,
    this.humidity,
    this.windSpeed,
    this.precipitationProbability,
    this.condition,
    this.aqi,
    this.extra,
  });

  factory WeatherForecastModel.fromMap(Map<String, dynamic> map) {
    return WeatherForecastModel(
      id: _parseObjectId(map['_id']),
      cityId: _parseObjectId(map['city_id']),
      forecastDate: _parseDate(map['forecast_date']) ?? DateTime.now(),
      minTemp: _parseDouble(map['min_temp']),
      maxTemp: _parseDouble(map['max_temp']),
      humidity: _parseDouble(map['humidity']),
      windSpeed: _parseDouble(map['wind_speed']),
      precipitationProbability: _parseDouble(map['precipitation_probability']),
      condition: map['condition']?.toString(),
      aqi: _parseInt(map['aqi']),
      extra: map['extra'] is Map<String, dynamic> ? map['extra'] as Map<String, dynamic> : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (cityId != null) 'city_id': cityId,
      'forecast_date': forecastDate,
      if (minTemp != null) 'min_temp': minTemp,
      if (maxTemp != null) 'max_temp': maxTemp,
      if (humidity != null) 'humidity': humidity,
      if (windSpeed != null) 'wind_speed': windSpeed,
      if (precipitationProbability != null) 'precipitation_probability': precipitationProbability,
      if (condition != null) 'condition': condition,
      if (aqi != null) 'aqi': aqi,
      if (extra != null) 'extra': extra,
    };
  }
}

ObjectId? _parseObjectId(dynamic value) {
  if (value is ObjectId) return value;
  if (value is String) {
    try {
      return ObjectId.fromHexString(value);
    } catch (_) {
      return null;
    }
  }
  return null;
}

double? _parseDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

int? _parseInt(dynamic value) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

DateTime? _parseDate(dynamic value) {
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
