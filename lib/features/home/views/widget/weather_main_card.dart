import 'package:flutter/material.dart';
import 'package:weather_app/model/models.dart';
import 'weather_daily_card.dart';

class WeatherMainCard extends StatelessWidget {
  final List<WeatherForecastModel> forecasts;
  final String locationName;
  const WeatherMainCard({
    super.key, 
    required this.forecasts, 
    required this.locationName});
  
  @override
  Widget build(BuildContext context) {
    final currentWeather = forecasts.isNotEmpty ? forecasts.first : null;

    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.gps_fixed, size: 32, color: Colors.green),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(locationName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SF Pro Display"
                      ),
                    ),
                    Text("Current Location",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "ABeeZee"
                      ),
                    )
                  ]
                ),
              ),
              
            ],
          ),
    
          SizedBox(height: 20),
    
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.cloudy_snowing, size: 32, color: Colors.blue),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      currentWeather != null ? "${currentWeather.maxTemp}°C" : "Temperature",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SF Pro Display"
                        ),
                      ),
                      Text("Status",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: "ABeeZee"
                        ),
                      ),
                ],
              )
            ],
          ),
    
          SizedBox(height: 20),
          
          Text("Weather Forcast",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "SF Pro Display"
            ),
          ),
          SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: forecasts.isEmpty
                  ? [const Text("No data",),]
                  : forecasts.map((forecast) => WeatherDailyCard(forecast: forecast)).toList(),
            ),
          )
        ],
      ),
    );
  }
}