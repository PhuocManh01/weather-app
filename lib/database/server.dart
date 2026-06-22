import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'database_initializer.dart';

class MongoDatabase {
  static late Db db;

  static Future<void> connect() async {
    db = await Db.create(
      'mongodb://localhost:27017/weather_app',
    );

    await db.open();

    debugPrint('MongoDB Connected');

    await DatabaseInitializer.initialize(db);
  }
}