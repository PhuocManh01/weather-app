import 'package:mongo_dart/mongo_dart.dart';

class RefreshTokenModel {
  final ObjectId? id;
  final ObjectId? userId;
  final String token;
  final DateTime createdAt;
  final DateTime expiredAt;
  final bool revoked;

  RefreshTokenModel({
    this.id,
    this.userId,
    required this.token,
    required this.createdAt,
    required this.expiredAt,
    this.revoked = false,
  });

  factory RefreshTokenModel.fromMap(Map<String, dynamic> map) {
    return RefreshTokenModel(
      id: _parseObjectId(map['_id']),
      userId: _parseObjectId(map['user_id']),
      token: map['token']?.toString() ?? '',
      createdAt: _parseDate(map['created_at']) ?? DateTime.now(),
      expiredAt: _parseDate(map['expired_at']) ?? DateTime.now(),
      revoked: map['revoked'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user_id': userId,
      'token': token,
      'created_at': createdAt,
      'expired_at': expiredAt,
      'revoked': revoked,
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
