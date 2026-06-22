import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/home/services/home_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final HomeService _homeService = HomeService();

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final data = await _homeService.fetchHomeData(event.city);
        emit(WeatherSuccess(data));
      } catch (e) {
        emit(WeatherFailure("Không thể kết nối máy chủ dữ liệu"));
      }
    });
  }
}