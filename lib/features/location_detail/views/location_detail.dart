// features/home/presentation/location_detail.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:weather_app/features/location_detail/bloc/location_detail_bloc.dart';
import 'package:weather_app/features/location_detail/bloc/weather_detail_state.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  // 🛠️ Converts DateTime to English short weekday names
  String _getWeekdayShort(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<WeatherDetailBloc, WeatherDetailState>(
        builder: (context, state) {
          
          if (state is WeatherDetailLoading || state is WeatherDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WeatherDetailError) {
            return Center(child: Text(state.message));
          }

          if (state is WeatherDetailSuccess) {
            final todayForecast = state.forecasts.first;
            
            double aqiPercent = todayForecast.aqi / 300.0;
            aqiPercent = aqiPercent.clamp(0.0, 1.0);

            String aqiLabel = "Low";
            if (todayForecast.aqi > 150) {
              aqiLabel = "High";
            } else if (todayForecast.aqi > 50) {
              aqiLabel = "Moderate";
            }

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        const Text(
                          "Current Location",
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.location_on_outlined),
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            state.locationName,
                            style: const TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Viet Nam",
                            style: TextStyle(fontFamily: "ABeeZee", fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Air Quality",
                                style: TextStyle(
                                  fontFamily: "SF Pro Display",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.info_outline, size: 20),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularPercentIndicator(
                                radius: 100.0,
                                lineWidth: 14.0,
                                percent: aqiPercent,
                                arcType: ArcType.HALF,
                                arcBackgroundColor: const Color.fromARGB(255, 220, 242, 220),
                                progressColor: const Color.fromARGB(255, 53, 222, 141),
                                circularStrokeCap: CircularStrokeCap.round,
                                animateFromLastPercent: true,
                                animation: true,
                                center: Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 5,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${todayForecast.aqi}",
                                            style: const TextStyle(
                                              fontFamily: "SF Pro Display",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "AQI",
                                            style: TextStyle(
                                              fontFamily: "ABeeZee",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.emoji_emotions),
                                          const SizedBox(width: 5),
                                          Text(
                                            aqiLabel,
                                            style: const TextStyle(
                                              fontFamily: "ABeeZee",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: Row(
                                  children: [
                                    buildVerticalBar(state.o3 / 150 > 1.0 ? 1.0 : state.o3 / 150, "O3 (ug/m3)", state.o3),
                                    const Spacer(),
                                    buildVerticalBar(state.pm10 / 150 > 1.0 ? 1.0 : state.pm10 / 150, "PM10 (ug/m3)", state.pm10),
                                    const Spacer(),
                                    buildVerticalBar(state.no2 / 150 > 1.0 ? 1.0 : state.no2 / 150, "NO (ug/m3)", state.no2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              buildVerticalBar(0.15, "NO2 (ug/m3)", 12),
                              const Spacer(),
                              buildVerticalBar(state.pm1 / 150 > 1.0 ? 1.0 : state.pm1 / 150, "PM1 (ug/m3)", state.pm1),
                              const Spacer(),
                              buildVerticalBar(state.pm25 / 150 > 1.0 ? 1.0 : state.pm25 / 150, "PM2.5 (ug/m3)", state.pm25),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          const Text(
                            "Weather",
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 5,
                                children: [
                                  const Text(
                                    "NOW",
                                    style: TextStyle(fontFamily: "ABeeZee", fontSize: 14),
                                  ),
                                  Text(
                                    todayForecast.condition,
                                    style: const TextStyle(
                                      fontFamily: "SF Pro Display",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Feels like ${todayForecast.maxTemp.toStringAsFixed(0)}°C",
                                    style: const TextStyle(fontFamily: "ABeeZee", fontSize: 14),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                todayForecast.maxTemp.toStringAsFixed(0),
                                style: const TextStyle(
                                  fontFamily: "SF Pro Display",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "°C",
                                style: TextStyle(fontFamily: "ABeeZee", fontSize: 18),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.wb_cloudy, size: 40, color: Colors.amber),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          const Text(
                            "Weather Forecast",
                            style: TextStyle(
                              fontFamily: "SF Pro Display",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Next 7 days",
                            style: TextStyle(fontFamily: "ABeeZee", fontSize: 14),
                          ),
                          ...state.forecasts.asMap().entries.map((entry) {
                            int index = entry.key;
                            final day = entry.value;

                            String? dayComment;
                            if (index == 0) dayComment = "TODAY";
                            if (index == 1) dayComment = "TOMORROW";

                            final String weekdayShort = _getWeekdayShort(day.forecastDate);

                            return buildDailyWeather(
                              day.forecastDate.toIso8601String().substring(0, 10),
                              weekdayShort, 
                              day.maxTemp.toInt(),
                              day.minTemp.toInt(),
                              const Icon(Icons.sunny, color: Colors.amberAccent),
                              dayComment,
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget buildVerticalBar(double percent, String unitText, double value) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: LinearPercentIndicator(
            barRadius: const Radius.circular(30),
            animation: true,
            backgroundColor: const Color.fromARGB(255, 220, 242, 220),
            progressColor: const Color.fromARGB(255, 53, 222, 141),
            lineHeight: 10,
            width: 80,
            percent: percent,
          ),
        ),
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              const SizedBox(height: 5),
              Text(
                unitText,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                  fontFamily: "ABeeZee",
                  fontSize: 12,
                ),
              ),
              Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                  fontFamily: "SF Pro Display",
                  overflow: TextOverflow.clip,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDailyWeather(String date, String weekday, int highTemp, int lowTemp, Icon stateIcon, String? cmt) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Renders as "Mon - 2026-04-20"
              Text(
                "$weekday - $date",
                style: const TextStyle(
                  fontFamily: "ABeeZee",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (cmt != null)
                Text(
                  cmt,
                  style: const TextStyle(fontFamily: "SF Pro Display", fontSize: 12),
                ),
            ],
          ),
          const Spacer(),
          Text(
            "$highTemp",
            style: const TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("°C", style: TextStyle(fontFamily: "ABeeZee", fontSize: 18)),
          const Icon(Icons.arrow_upward, size: 20, color: Colors.green),
          const SizedBox(width: 10),
          Text(
            "$lowTemp",
            style: const TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("°C", style: TextStyle(fontFamily: "ABeeZee", fontSize: 18)),
          const Icon(Icons.arrow_downward, size: 20, color: Colors.red),
          const SizedBox(width: 20),
          stateIcon,
        ],
      ),
    );
  }
}