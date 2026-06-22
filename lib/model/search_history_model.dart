import 'package:mongo_dart/mongo_dart.dart';

class SearchHistoryModel {
  final ObjectId? id;
  final ObjectId? userId;
  final String query;
  final DateTime searchedAt;
  final Map<String, dynamic>? metadata;

  SearchHistoryModel({
    this.id,
    this.userId,
    required this.query,
    required this.searchedAt,
    this.metadata,
  });

  factory SearchHistoryModel.fromMap(Map<String, dynamic> map) {
    return SearchHistoryModel(
      id: _parseObjectId(map['_id']),
      userId: _parseObjectId(map['user_id']),
      query: map['query']?.toString() ?? '',
      searchedAt: _parseDate(map['searched_at']) ?? DateTime.now(),
      metadata: map['metadata'] is Map<String, dynamic> ? map['metadata'] as Map<String, dynamic> : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user_id': userId,
      'query': query,
      'searched_at': searchedAt,
      if (metadata != null) 'metadata': metadata,
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
