class WeatherService {
  Map<String, double> calculatePollutants(int aqiValue) {
    return {
      'pm25': aqiValue * 0.35,
      'pm10': aqiValue * 0.6,
      'o3': aqiValue * 0.85,
      'no2': aqiValue * 0.25,
      'pm1': aqiValue * 0.2,
    };
  }
}