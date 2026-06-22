import 'package:weather_app/model/models.dart';

abstract class WeatherState {}
class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherSuccess extends WeatherState {
  final List<WeatherForecastModel> forecasts;
  WeatherSuccess(this.forecasts);
}
class WeatherFailure extends WeatherState {
  final String message;
  WeatherFailure(this.message);
}