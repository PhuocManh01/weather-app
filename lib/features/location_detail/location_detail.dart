import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    "Current Location",
                    style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.location_on_outlined),
                ],
              ),
        
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      "Church Street Square",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Birmingham",
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
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Air Quality",
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.info_outline, size: 20),
                      ],
                    ),
        
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 100.0,
                          lineWidth: 14.0,
                          percent: 0.3,
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
                                      "3",
                                      style: TextStyle(
                                        fontFamily: "SF Pro Display",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
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
                                    Icon(Icons.emoji_emotions),
                                    SizedBox(width: 5),
                                    Text(
                                      "Low",
                                      style: TextStyle(
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
                          padding: EdgeInsetsGeometry.only(top: 150),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  buildVerticalBar(0.3, "O3 (ug/m3)", 52),
                                  const Spacer(),
                                  buildVerticalBar(0.5, "PM10 (ug/m3)", 25),
                                  const Spacer(),
                                  buildVerticalBar(0.2, "NO (ug/m3)", 22),
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
                        buildVerticalBar(0.4, "PM1 (ug/m3)", 16),
                        const Spacer(),
                        buildVerticalBar(0.6, "PM2.5 (ug/m3)", 2.2),
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
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
                            Text(
                              "NOW",
                              style: TextStyle(
                                fontFamily: "ABeeZee",
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Rain Shower",
                              style: TextStyle(
                                fontFamily: "SF Pro Display",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Feels like 11°C",
                              style: TextStyle(
                                fontFamily: "ABeeZee",
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
        
                        const Spacer(),
        
                        Text(
                          "15",
                          style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "°C",
                          style: TextStyle(fontFamily: "ABeeZee", fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.wb_cloudy, size: 40, color: Colors.amber),
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Weather Forcast",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        
                    Text(
                      "Next 7 days",
                      style: TextStyle(fontFamily: "ABeeZee", fontSize: 14),
                    ),
        
                    buildDailyWeather("THU 11 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), "TODAY"),
                    buildDailyWeather("FRI 12 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), "TOMORROW"),
                    buildDailyWeather("SAT 13 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), null),
                    buildDailyWeather("SUN 14 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), null),
                    buildDailyWeather("MON 15 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), null),
                    buildDailyWeather("TUE 16 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), null),
                    buildDailyWeather("WED 17 NOV 21", 30, 28, Icon(Icons.sunny, color: Colors.amberAccent), null),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            barRadius: Radius.circular(30),
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
              SizedBox(height: 5),
              Text(
                unitText,
                style: TextStyle(
                  overflow: TextOverflow.clip,
                  fontFamily: "ABeeZee",
                  fontSize: 12,
                ),
              ),
              Text(
                value.toString(),
                style: TextStyle(
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
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  overflow: TextOverflow.clip,
                  fontFamily: "ABeeZee",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (cmt != null)
                Text(
                  "Today",
                  style: TextStyle(
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
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "°C",
            style: TextStyle(fontFamily: "ABeeZee", fontSize: 18),
          ),
          Icon(Icons.arrow_upward, size: 20, color: Colors.green),
          SizedBox(width: 10),
          Text(
            lowTemp.toString(),
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "°C",
            style: TextStyle(fontFamily: "ABeeZee", fontSize: 18),
          ),
          Icon(Icons.arrow_downward, size: 20, color: const Color.fromARGB(255, 255, 43, 43)),
          SizedBox(width: 20,),
          state
        ],
      ),
    );
  }
}
