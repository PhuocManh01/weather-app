import 'package:flutter/material.dart';

class AQIScale extends StatelessWidget {
  const AQIScale({super.key});

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
                  SizedBox(width: 100,),
                  Text(
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
                padding: EdgeInsets.all(20),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.gps_fixed_outlined, color: Colors.lightBlue, size: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: TextStyle(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.cloudy_snowing, color: const Color.fromARGB(255, 62, 65, 253), size: 30,),
                        SizedBox(width: 20),
                        Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "19",
                                  style: TextStyle(
                                    fontFamily: "SF Pro Display",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  style: TextStyle(
                                    fontFamily: "ABeeZee",
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(Icons.arrow_upward, color: Colors.green, size: 16,)
                              ],
                            ),
                            Row(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Rain Shower",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SF Pro Display",
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Feels like 11°C",
                                  style: TextStyle(
                                    fontFamily: "ABeeZee",
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "3",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "SF Pro Display",
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "AQI",
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Icon(Icons.emoji_emotions_outlined, size: 30, color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    buildAQIScaleItem(
                      Icon(Icons.emoji_emotions_outlined, size: 30, color: Colors.green),
                      "Low",
                      1,
                      3,
                      "Air quality can change quickly due to both weather and human activity. Air quality forecasts are often adjusted based on weather patterns. But pollution from human activity can drastically affect air quality forecasts within hours or even minutes. ..."
                    ),
                    buildAQIScaleItem(
                      Icon(Icons.sentiment_neutral, size: 30, color: Colors.yellow[700]),
                      "Moderate",
                      4,
                      6,
                      "Air quality can change quickly due to both weather and human activity. Air quality forecasts are often adjusted based on weather patterns. But pollution from human activity can drastically affect air quality forecasts within hours or even minutes. ..."
                    ),
                    buildAQIScaleItem(
                      Icon(Icons.mood_bad_sharp, size: 30, color: Colors.orange),
                      "High",
                      7,
                      8,
                      "Air quality can change quickly due to both weather and human activity. Air quality forecasts are often adjusted based on weather patterns. But pollution from human activity can drastically affect air quality forecasts within hours or even minutes. ..."
                    ),
                    buildAQIScaleItem(
                      Icon(Icons.dangerous, size: 30, color: Colors.red),
                      "Very High",
                      9,
                      10,
                      "Air quality can change quickly due to both weather and human activity. Air quality forecasts are often adjusted based on weather patterns. But pollution from human activity can drastically affect air quality forecasts within hours or even minutes. ..."
                    ),
                  ]
                )
              )
            ],
          ),
        ),
      )
    );
  }

  Widget buildAQIScaleItem(Icon state, String title, int low, int high, String description) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state,
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "SF Pro Display",
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Air Quality Index: ${low} to ${high}",
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: "ABeeZee",
                    fontSize: 12,
                    color: Colors.grey,
                    overflow: TextOverflow.clip,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Show More",
                    style: TextStyle(
                      fontFamily: "ABeeZee",
                      fontSize: 12,
                      color: Colors.blueAccent,
                    ),
                  )
                ),
                SizedBox(height: 20,),
              ],
            ),
          )
        ]
      ),
    );
  }
}