import 'package:flutter/material.dart';

class SavedLocationCard extends StatelessWidget {
  final String place;
  final String address;
  final int aqi; 
  final double temperature;
  final String condition;

  const SavedLocationCard({
    super.key,
    required this.place,
    required this.address,
    required this.aqi,
    required this.temperature,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    
    IconData aqiIcon = Icons.sentiment_satisfied_alt;
    Color aqiColor = Colors.green;
    if (aqi > 100) {
      aqiIcon = Icons.sentiment_very_dissatisfied;
      aqiColor = Colors.red;
    } else if (aqi > 50) {
      aqiIcon = Icons.sentiment_neutral;
      aqiColor = Colors.orange;
    }

    
    IconData weatherIcon = Icons.wb_sunny;
    Color weatherColor = Colors.orange;
    final condLower = condition.toLowerCase();
    if (condLower.contains('rain') || condLower.contains('shower')) {
      weatherIcon = Icons.umbrella;
      weatherColor = Colors.blue;
    } else if (condLower.contains('cloud') || condLower.contains('overcast')) {
      weatherIcon = Icons.cloud;
      weatherColor = Colors.grey;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "SF Pro Display"
            ),
          ),

          Text(
            address,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "ABeeZee"
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              
              Icon(aqiIcon, size: 16, color: aqiColor),
              Text(
                "$aqi",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "AQI",
                style: TextStyle(color: Colors.grey, fontSize: 10, fontFamily: "ABeeZee"),
              ),
              
              const SizedBox(width: 15),

              
              Text(
                "${temperature.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "°C",
                style: TextStyle(color: Colors.grey, fontSize: 10, fontFamily: "ABeeZee"),
              ),
              Icon(weatherIcon, size: 16, color: weatherColor),
            ],
          )
        ],
      ),
    );
  }
}