import 'package:mongo_dart/mongo_dart.dart';

class AlertModel {
  final ObjectId? id;
  final ObjectId? userId;
  final ObjectId? cityId;
  final String type;
  final String message;
  final bool enabled;
  final DateTime? triggerAt;
  final Map<String, dynamic>? criteria;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AlertModel({
    this.id,
    this.userId,
    this.cityId,
    required this.type,
    required this.message,
    this.enabled = true,
    this.triggerAt,
    this.criteria,
    this.createdAt,
    this.updatedAt,
  });

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      id: _parseObjectId(map['_id']),
      userId: _parseObjectId(map['user_id']),
      cityId: _parseObjectId(map['city_id']),
      type: map['type']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      enabled: map['enabled'] == true,
      triggerAt: _parseDate(map['trigger_at']),
      criteria: map['criteria'] is Map<String, dynamic> ? map['criteria'] as Map<String, dynamic> : null,
      createdAt: _parseDate(map['created_at']),
      updatedAt: _parseDate(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user_id': userId,
      if (cityId != null) 'city_id': cityId,
      'type': type,
      'message': message,
      'enabled': enabled,
      if (triggerAt != null) 'trigger_at': triggerAt,
      if (criteria != null) 'criteria': criteria,
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
