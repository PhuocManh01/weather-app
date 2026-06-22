// features/location_detail/bloc/location_detail_state.dart
import 'package:equatable/equatable.dart';
import 'package:weather_app/model/models.dart';

abstract class WeatherDetailState extends Equatable {
  const WeatherDetailState();
  
  @override
  List<Object?> get props => [];
}

class WeatherDetailInitial extends WeatherDetailState {}

class WeatherDetailLoading extends WeatherDetailState {}

class WeatherDetailSuccess extends WeatherDetailState {
  final List<WeatherForecastModel> forecasts;
  final String locationName;
  final double pm25;
  final double pm10;
  final double o3;
  final double no2;
  final double pm1;

  const WeatherDetailSuccess({
    required this.forecasts,
    required this.locationName,
    required this.pm25,
    required this.pm10,
    required this.o3,
    required this.no2,
    required this.pm1,
  });

  @override
  List<Object?> get props => [forecasts, locationName, pm25, pm10, o3, no2, pm1];
}

class WeatherDetailError extends WeatherDetailState {
  final String message;
  const WeatherDetailError(this.message);

  @override
  List<Object?> get props => [message];
}