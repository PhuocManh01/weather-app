import 'package:equatable/equatable.dart';

abstract class WeatherDetailEvent extends Equatable {
  const WeatherDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherDetail extends WeatherDetailEvent {
  final String city;
  const FetchWeatherDetail(this.city);

  @override
  List<Object> get props => [city];
}