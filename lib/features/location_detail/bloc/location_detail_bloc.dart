// features/location_detail/bloc/location_detail_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
// Giữ nguyên HomeService nếu bạn để nó bên tính năng home chung
import 'package:weather_app/features/home/services/home_service.dart'; 
import 'package:weather_app/features/location_detail/bloc/location_detail_event.dart';
import 'package:weather_app/features/location_detail/bloc/weather_detail_state.dart';
import 'package:weather_app/features/location_detail/services/weather_service.dart';

class WeatherDetailBloc extends Bloc<WeatherDetailEvent, WeatherDetailState> {
  final HomeService homeService;
  final WeatherService weatherService;

  WeatherDetailBloc({
    required this.homeService,
    required this.weatherService,
  }) : super(WeatherDetailInitial()) {
    on<FetchWeatherDetail>(_onFetchWeatherDetail);
  }

  Future<void> _onFetchWeatherDetail(
    FetchWeatherDetail event,
    Emitter<WeatherDetailState> emit,
  ) async {
    emit(WeatherDetailLoading());
    try {
      final forecasts = await homeService.fetchHomeData(event.city);
      
      if (forecasts.isNotEmpty) {
        final today = forecasts.first;
        final pollutants = weatherService.calculatePollutants(today.aqi);

        emit(WeatherDetailSuccess(
          forecasts: forecasts,
          locationName: event.city,
          pm25: pollutants['pm25']!,
          pm10: pollutants['pm10']!,
          o3: pollutants['o3']!,
          no2: pollutants['no2']!,
          pm1: pollutants['pm1']!,
        ));
      } else {
        emit(const WeatherDetailError("Không có dữ liệu dự báo"));
      }
    } catch (e) {
      emit(WeatherDetailError(e.toString()));
    }
  }
}