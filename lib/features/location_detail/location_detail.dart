import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:weather_app/features/home/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/bloc/weather_state.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
        
          String locationName = "Da Nang";
          String condition = "Rain Shower";
          int aqiValue = 3;
          double currentTemp = 15.0;

        
          double o3 = 52.0;
          double pm10 = 25.0;
          double no2 = 22.0;
          double pm1 = 16.0;
          double pm25 = 2.2;

          if (state is WeatherSuccess && state.forecasts.isNotEmpty) {
            final today = state.forecasts.first;
            locationName = "Da Nang";
            condition = today.condition;
            aqiValue = today.aqi;
            currentTemp = today.maxTemp;

          
            pm25 = aqiValue * 0.35;
            pm10 = aqiValue * 0.6;
            o3 = aqiValue * 0.85;
            no2 = aqiValue * 0.25;
            pm1 = aqiValue * 0.2;
          }

        
          double aqiPercent = aqiValue / 300.0;
          if (aqiPercent > 1.0) aqiPercent = 1.0;
          if (aqiPercent < 0.0) aqiPercent = 0.0;

        
          String aqiLabel = "Low";
          if (aqiValue > 150) {
            aqiLabel = "High";
          } else if (aqiValue > 50) {
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                          locationName,
                          
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              arcBackgroundColor: const Color.fromARGB(
                                255,
                                220,
                                242,
                                220,
                              ),
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
                                          "$aqiValue",
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
                              child: Column(
                                spacing: 10,
                                children: [
                                  Row(
                                    children: [
                                    
                                      buildVerticalBar(o3 / 150 > 1.0 ? 1.0 : o3 / 150, "O3 (ug/m3)", o3),
                                      const Spacer(),
                                      buildVerticalBar(pm10 / 150 > 1.0 ? 1.0 : pm10 / 150, "PM10 (ug/m3)", pm10),
                                      const Spacer(),
                                      buildVerticalBar(no2 / 150 > 1.0 ? 1.0 : no2 / 150, "NO (ug/m3)", no2),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                          
                            buildVerticalBar(0.15, "NO2 (ug/m3)mmmm", 12),
                            const Spacer(),
                            buildVerticalBar(pm1 / 150 > 1.0 ? 1.0 : pm1 / 150, "PM1 (ug/m3)", pm1),
                            const Spacer(),
                            buildVerticalBar(pm25 / 150 > 1.0 ? 1.0 : pm25 / 150, "PM2.5 (ug/m3)", pm25),
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
                                  style: TextStyle(
                                    fontFamily: "ABeeZee",
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  condition,
                                  style: const TextStyle(
                                    fontFamily: "SF Pro Display",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Feels like ${currentTemp.toStringAsFixed(0)}°C",
                                  style: const TextStyle(
                                    fontFamily: "ABeeZee",
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
            
                            const Spacer(),
            
                            Text(
                              currentTemp.toStringAsFixed(0),
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
                          "Weather Forcast",
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
            
                      
                        if (state is WeatherSuccess)
                          ...state.forecasts.asMap().entries.map((entry) {
                            int index = entry.key;
                            final day = entry.value;
                            
                            String? dayComment;
                            if (index == 0) dayComment = "TODAY";
                            if (index == 1) dayComment = "TOMORROW";

                            return buildDailyWeather(
                              day.forecastDate.toIso8601String(), 
                              day.maxTemp.toInt(), 
                              day.minTemp.toInt(), 
                              const Icon(Icons.sunny, color: Colors.amberAccent), 
                              dayComment
                            );
                          })
                        else ...[
                        
                          buildDailyWeather("THU 11 NOV 21", 30, 28, const Icon(Icons.sunny, color: Colors.amberAccent), "TODAY"),
                          buildDailyWeather("FRI 12 NOV 21", 30, 28, const Icon(Icons.sunny, color: Colors.amberAccent), "TOMORROW"),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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


  Widget buildDailyWeather(String date, int highTemp, int lowTemp, Icon state, String? cmt) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                  fontFamily: "ABeeZee",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (cmt != null)
                Text(
                  cmt,
                  style: const TextStyle(
                    fontFamily: "SF Pro Display",
                    overflow: TextOverflow.clip,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            highTemp.toString(),
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
          const Icon(Icons.arrow_upward, size: 20, color: Colors.green),
          const SizedBox(width: 10),
          Text(
            lowTemp.toString(),
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
          const Icon(Icons.arrow_downward, size: 20, color: Color.fromARGB(255, 255, 43, 43)),
          const SizedBox(width: 20,),
          state
        ],
      ),
    );
  }
}