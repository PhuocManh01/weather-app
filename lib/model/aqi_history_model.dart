import 'package:mongo_dart/mongo_dart.dart';

class AqiHistoryModel {
  final ObjectId? id;
  final ObjectId? cityId;
  final DateTime recordedAt;
  final int aqi;
  final int? pm25;
  final int? pm10;
  final int? o3;
  final int? no2;
  final int? so2;
  final int? co;
  final Map<String, dynamic>? extra;

  AqiHistoryModel({
    this.id,
    this.cityId,
    required this.recordedAt,
    required this.aqi,
    this.pm25,
    this.pm10,
    this.o3,
    this.no2,
    this.so2,
    this.co,
    this.extra,
  });

  factory AqiHistoryModel.fromMap(Map<String, dynamic> map) {
    return AqiHistoryModel(
      id: _parseObjectId(map['_id']),
      cityId: _parseObjectId(map['city_id']),
      recordedAt: _parseDate(map['recorded_at']) ?? DateTime.now(),
      aqi: _parseInt(map['aqi']) ?? 0,
      pm25: _parseInt(map['pm25']),
      pm10: _parseInt(map['pm10']),
      o3: _parseInt(map['o3']),
      no2: _parseInt(map['no2']),
      so2: _parseInt(map['so2']),
      co: _parseInt(map['co']),
      extra: map['extra'] is Map<String, dynamic> ? map['extra'] as Map<String, dynamic> : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (cityId != null) 'city_id': cityId,
      'recorded_at': recordedAt,
      'aqi': aqi,
      if (pm25 != null) 'pm25': pm25,
      if (pm10 != null) 'pm10': pm10,
      if (o3 != null) 'o3': o3,
      if (no2 != null) 'no2': no2,
      if (so2 != null) 'so2': so2,
      if (co != null) 'co': co,
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
