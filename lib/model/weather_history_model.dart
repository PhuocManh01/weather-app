import 'package:mongo_dart/mongo_dart.dart';

class WeatherHistoryModel {
  final ObjectId? id;
  final ObjectId? cityId;
  final DateTime recordedAt;
  final double? temperature;
  final double? humidity;
  final int? pressure;
  final double? windSpeed;
  final String? condition;
  final int? aqi;
  final Map<String, dynamic>? extra;

  WeatherHistoryModel({
    this.id,
    this.cityId,
    required this.recordedAt,
    this.temperature,
    this.humidity,
    this.pressure,
    this.windSpeed,
    this.condition,
    this.aqi,
    this.extra,
  });

  factory WeatherHistoryModel.fromMap(Map<String, dynamic> map) {
    return WeatherHistoryModel(
      id: _parseObjectId(map['_id']),
      cityId: _parseObjectId(map['city_id']),
      recordedAt: _parseDate(map['recorded_at']) ?? DateTime.now(),
      temperature: _parseDouble(map['temperature']),
      humidity: _parseDouble(map['humidity']),
      pressure: _parseInt(map['pressure']),
      windSpeed: _parseDouble(map['wind_speed']),
      condition: map['condition']?.toString(),
      aqi: _parseInt(map['aqi']),
      extra: map['extra'] is Map<String, dynamic> ? map['extra'] as Map<String, dynamic> : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (cityId != null) 'city_id': cityId,
      'recorded_at': recordedAt,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (pressure != null) 'pressure': pressure,
      if (windSpeed != null) 'wind_speed': windSpeed,
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
