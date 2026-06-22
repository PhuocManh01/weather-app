import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appVersion = "v1";
    const String appDescription = "Our Weather & AQI Application is built to provide real-time, highly accurate weather forecasts and Air Quality Index (AQI) monitoring.";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "About Us",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
          
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.wb_sunny_rounded,
                size: 55,
                color: Colors.green,
              ),
            ),
            
            const SizedBox(height: 32),

          
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: Colors.grey, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Application Name",
                              style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "ABeeZee"),
                            ),
                            Text(
                              "Smart Weather & AQI",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "SF Pro Display"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          appVersion,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green, fontFamily: "ABeeZee"),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 1, thickness: 0.5, color: Colors.black12),

                
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: const [
                      Text(
                        "Our Mission",
                        style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "ABeeZee"),
                      ),
                      Text(
                        appDescription,
                        style: TextStyle(
                          fontSize: 14, 
                          fontFamily: "SF Pro Display", 
                          color: Colors.black87,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}