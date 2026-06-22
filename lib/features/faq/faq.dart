import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  // 📝 DANH SÁCH CÂU HỎI & CÂU TRẢ LỜI TĨNH (Phù hợp cho app thời tiết & chất lượng không khí)
  final List<Map<String, String>> faqData = const [
    {
      "question": "How is the Air Quality Index (AQI) calculated?",
      "answer": "AQI is calculated based on the concentration of major air pollutants measured in the air, such as PM2.5, PM10, Ozone, and Nitrogen Dioxide. The highest pollutant value determines the overall AQI score."
    },
    {
      "question": "How often is the weather and AQI data updated?",
      "answer": "Our system synchronizes and updates the data every 15 to 30 minutes directly from local IoT monitoring stations and global meteorological services to ensure real-time accuracy."
    },
    {
      "question": "What should I do when the AQI is in the 'Unhealthy' range?",
      "answer": "When the AQI is unhealthy, it is highly recommended to wear an anti-pollution mask (like N95) outdoors, close your windows, run an indoor air purifier, and minimize prolonged outdoor activities."
    },
    {
      "question": "Can I set up automatic alerts for poor air quality?",
      "answer": "Yes! You can enable notifications in the profile settings. The application will immediately send an alert if the AQI in your saved locations exceeds safe levels."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Nền xám nhẹ đồng bộ với AQIScale
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "FAQs",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: faqData.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12), // Khoảng cách giữa các card
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), // Bo tròn đồng bộ AQIScale Card
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Theme(
                  // Xóa đường gạch ngang mặc định của ExpansionTile khi mở ra
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: Colors.green, // Màu của mũi tên khi xổ xuống
                    collapsedIconColor: Colors.grey, // Màu mũi tên khi đóng
                    leading: const Icon(Icons.help_outline_rounded, color: Colors.green),
                    title: Text(
                      faqData[index]["question"]!,
                      style: const TextStyle(
                        fontFamily: "SF Pro Display",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.only(left: 56, right: 16, bottom: 16),
                    children: [
                      Text(
                        faqData[index]["answer"]!,
                        style: const TextStyle(
                          fontFamily: "ABeeZee",
                          fontSize: 13,
                          color: Colors.black54,
                          height: 1.4, // Giúp giãn dòng text đọc dễ chịu hơn
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}