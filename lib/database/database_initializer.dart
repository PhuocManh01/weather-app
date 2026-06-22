import 'package:mongo_dart/mongo_dart.dart';

class DatabaseInitializer {
  static Future<void> initialize(Db db) async {
    await _createUsersIndexes(db);
    await _createCitiesIndexes(db);
    await _createLocationsIndexes(db);
    await _createWeatherHistoryIndexes(db);
    await _createWeatherForecastIndexes(db);
    await _createAqiHistoryIndexes(db);
    await _createSearchHistoryIndexes(db);
    await _createRefreshTokenIndexes(db);
    await _createAlertsIndexes(db);

    print('Database initialized successfully');
  }

  static Future<void> _createUsersIndexes(Db db) async {
    final collection = db.collection('users');

    await collection.createIndex(
      keys: {'username': 1},
      unique: true,
    );
  }

  static Future<void> _createCitiesIndexes(Db db) async {
    final collection = db.collection('cities');

    await collection.createIndex(
      keys: {
        'city_name': 1,
        'country_code': 1,
      },
      unique: true,
    );
  }

  static Future<void> _createLocationsIndexes(Db db) async {
    final collection = db.collection('locations');

    await collection.createIndex(
      keys: {
        'user_id': 1,
        'city_id': 1,
      },
    );
  }

  static Future<void> _createWeatherHistoryIndexes(Db db) async {
    final collection = db.collection('weather_history');

    await collection.createIndex(
      keys: {
        'city_id': 1,
        'recorded_at': -1,
      },
    );
  }

  static Future<void> _createWeatherForecastIndexes(Db db) async {
    final collection = db.collection('weather_forecast');

    await collection.createIndex(
      keys: {
        'city_id': 1,
        'forecast_date': 1,
      },
    );
  }

  static Future<void> _createAqiHistoryIndexes(Db db) async {
    final collection = db.collection('aqi_history');

    await collection.createIndex(
      keys: {
        'city_id': 1,
        'recorded_at': -1,
      },
    );
  }

  static Future<void> _createSearchHistoryIndexes(Db db) async {
    final collection = db.collection('search_history');

    await collection.createIndex(
      keys: {
        'user_id': 1,
        'searched_at': -1,
      },
    );
  }

  static Future<void> _createRefreshTokenIndexes(Db db) async {
    final collection = db.collection('refresh_tokens');

    await collection.createIndex(
      keys: {
        'user_id': 1,
      },
    );

    // TTL index
    await collection.createIndex(
      keys: {
        'expired_at': 1,
      },
    );
  }

  static Future<void> _createAlertsIndexes(Db db) async {
    final collection = db.collection('alerts');

    await collection.createIndex(
      keys: {
        'user_id': 1,
        'city_id': 1,
      },
    );
  }
}