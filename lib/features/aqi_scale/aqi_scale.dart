import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/aqi_scale/widget/aqi_scale_item.dart';
import 'package:weather_app/features/home/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/bloc/weather_state.dart';

class AQIScalePage extends StatelessWidget {
  const AQIScalePage({super.key});


  Map<String, dynamic> _getAqiTheme(int aqi) {
    if (aqi <= 50) {
      return {
        'color': Colors.green,
        'label': 'Good',
        'icon': const Icon(Icons.emoji_emotions_outlined, size: 30, color: Colors.green),
      };
    } else if (aqi <= 100) {
      return {
        'color': Colors.yellow[700]!,
        'label': 'Moderate',
        'icon': Icon(Icons.sentiment_neutral, size: 30, color: Colors.yellow[700]),
      };
    } else if (aqi <= 150) {
      return {
        'color': Colors.orange,
        'label': 'Unhealthy for Sensitive Groups',
        'icon': const Icon(Icons.sentiment_dissatisfied_outlined, size: 30, color: Colors.orange),
      };
    } else if (aqi <= 200) {
      return {
        'color': Colors.red,
        'label': 'Unhealthy',
        'icon': const Icon(Icons.mood_bad_sharp, size: 30, color: Colors.red),
      };
    } else if (aqi <= 300) {
      return {
        'color': Colors.purple,
        'label': 'Very Unhealthy',
        'icon': const Icon(Icons.warning_amber_rounded, size: 30, color: Colors.purple),
      };
    } else {
      return {
        'color': const Color(0xFF7E0023),
        'label': 'Hazardous',
        'icon': const Icon(Icons.dangerous, size: 30, color: Color(0xFF7E0023)),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
        
          String locationName = "Da Nang";
          String country = "Viet Nam";
          double temperature = 0.0;
          String condition = "No Data";
          int aqi = 0;

          if (state is WeatherSuccess && state.forecasts.isNotEmpty) {
            final today = state.forecasts.first;
            locationName = "Da Nang"; 
            country = "Viet Nam";
            temperature = today.maxTemp;
            condition = today.condition;
            aqi = today.aqi;
          }

          final currentTheme = _getAqiTheme(aqi);

          return SafeArea(
            child: SingleChildScrollView(
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
                        const SizedBox(width: 80),
                        const Text(
                          "AQI Scale",
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          Row(
                            spacing: 20,
                            children: [
                              const Icon(Icons.gps_fixed_outlined, color: Colors.lightBlue, size: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locationName,
                                    style: const TextStyle(
                                      fontFamily: "SF Pro Display",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    country,
                                    style: const TextStyle(
                                      fontFamily: "ABeeZee",
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),

                          Row(
                            children: [
                              const Icon(Icons.cloudy_snowing, color: Color.fromARGB(255, 62, 65, 253), size: 30),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 5,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${temperature.toStringAsFixed(0)}",
                                        style: const TextStyle(
                                          fontFamily: "SF Pro Display",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "°C",
                                        style: TextStyle(fontFamily: "ABeeZee", fontSize: 12, color: Colors.grey),
                                      ),
                                      const Icon(Icons.arrow_upward, color: Colors.green, size: 16)
                                    ],
                                  ),
                                  Row(
                                    spacing: 5,
                                    children: [
                                      Text(
                                        condition,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF Pro Display",
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Level: ${currentTheme['label']}",
                                        style: TextStyle(
                                          fontFamily: "ABeeZee", 
                                          fontSize: 12, 
                                          color: currentTheme['color'],
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "$aqi",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: "SF Pro Display", fontSize: 18),
                              ),
                              const Text(
                                " AQI",
                                style: TextStyle(fontFamily: "ABeeZee", fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(width: 15),
                              currentTheme['icon'],
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                  
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          AQIScaleItem(
                            stateIcon: const Icon(Icons.emoji_emotions_outlined, size: 30, color: Colors.green),
                            title: "Good",
                            rangeStr: "0 - 50",
                            healthImplications: "Air quality is considered satisfactory, and air pollution poses little or no risk.",
                            cautionaryStatement: "None",
                            currentAqi: aqi,
                            lowRange: 0,
                            highRange: 50,
                            themeColor: Colors.green,
                          ),
                          AQIScaleItem(
                            stateIcon: Icon(Icons.sentiment_neutral, size: 30, color: Colors.yellow[700]),
                            title: "Moderate",
                            rangeStr: "51 - 100",
                            healthImplications: "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.",
                            cautionaryStatement: "Active children and adults, and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion.",
                            currentAqi: aqi,
                            lowRange: 51,
                            highRange: 100,
                            themeColor: Colors.yellow[700]!,
                          ),
                          AQIScaleItem(
                            stateIcon: const Icon(Icons.sentiment_dissatisfied_outlined, size: 30, color: Colors.orange),
                            title: "Unhealthy for Sensitive Groups",
                            rangeStr: "101 - 150",
                            healthImplications: "Members of sensitive groups may experience health effects. The general public is not likely to be affected.",
                            cautionaryStatement: "Active children and adults, and people with respiratory disease, such as asthma, should limit prolonged outdoor exertion.",
                            currentAqi: aqi,
                            lowRange: 101,
                            highRange: 150,
                            themeColor: Colors.orange,
                          ),
                          AQIScaleItem(
                            stateIcon: const Icon(Icons.mood_bad_sharp, size: 30, color: Colors.red),
                            title: "Unhealthy",
                            rangeStr: "151 - 200",
                            healthImplications: "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.",
                            cautionaryStatement: "Active children and adults, and people with respiratory disease, such as asthma, should avoid prolonged outdoor exertion; everyone else, especially children, should limit prolonged outdoor exertion.",
                            currentAqi: aqi,
                            lowRange: 151,
                            highRange: 200,
                            themeColor: Colors.red,
                          ),
                          AQIScaleItem(
                            stateIcon: const Icon(Icons.warning_amber_rounded, size: 30, color: Colors.purple),
                            title: "Very Unhealthy",
                            rangeStr: "201 - 300",
                            healthImplications: "Health warnings of emergency conditions. The entire population is more likely to be affected.",
                            cautionaryStatement: "Active children and adults, and people with respiratory disease, such as asthma, should avoid all outdoor exertion; everyone else, especially children, should limit outdoor exertion.",
                            currentAqi: aqi,
                            lowRange: 201,
                            highRange: 300,
                            themeColor: Colors.purple,
                          ),
                          AQIScaleItem(
                            stateIcon: const Icon(Icons.dangerous, size: 30, color: Color(0xFF7E0023)),
                            title: "Hazardous",
                            rangeStr: "300+",
                            healthImplications: "Health alert: everyone may experience more serious health effects.",
                            cautionaryStatement: "Everyone should avoid all outdoor exertion.",
                            currentAqi: aqi,
                            lowRange: 301,
                            highRange: 999,
                            themeColor: const Color(0xFF7E0023),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}