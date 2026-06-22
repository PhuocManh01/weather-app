import 'package:mongo_dart/mongo_dart.dart';

class LocationModel {
  final ObjectId? id;
  final ObjectId? userId;
  final ObjectId? cityId;
  final String? alias;
  final bool isPrimary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LocationModel({
    this.id,
    this.userId,
    this.cityId,
    this.alias,
    this.isPrimary = false,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: _parseObjectId(map['_id']),
      userId: _parseObjectId(map['user_id']),
      cityId: _parseObjectId(map['city_id']),
      alias: map['alias']?.toString(),
      isPrimary: map['is_primary'] == true,
      createdAt: _parseDate(map['created_at']),
      updatedAt: _parseDate(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user_id': userId,
      if (cityId != null) 'city_id': cityId,
      if (alias != null) 'alias': alias,
      'is_primary': isPrimary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
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

DateTime? _parseDate(dynamic value) {
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}
