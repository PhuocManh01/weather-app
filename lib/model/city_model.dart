import 'package:mongo_dart/mongo_dart.dart';

class CityModel {
  final ObjectId? id;
  final String cityName;
  final String countryCode;
  final double? latitude;
  final double? longitude;
  final String? state;
  final String? timezone;
  final DateTime? createdAt;

  CityModel({
    this.id,
    required this.cityName,
    required this.countryCode,
    this.latitude,
    this.longitude,
    this.state,
    this.timezone,
    this.createdAt,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: _parseObjectId(map['_id']),
      cityName: map['city_name']?.toString() ?? '',
      countryCode: map['country_code']?.toString() ?? '',
      latitude: _parseDouble(map['latitude']),
      longitude: _parseDouble(map['longitude']),
      state: map['state']?.toString(),
      timezone: map['timezone']?.toString(),
      createdAt: _parseDate(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'city_name': cityName,
      'country_code': countryCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (state != null) 'state': state,
      if (timezone != null) 'timezone': timezone,
      if (createdAt != null) 'created_at': createdAt,
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

DateTime? _parseDate(dynamic value) {
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
