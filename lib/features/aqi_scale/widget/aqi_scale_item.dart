

import 'package:flutter/material.dart';

class AQIScaleItem extends StatelessWidget {
  final Icon stateIcon;
  final String title;
  final String rangeStr;
  final String healthImplications;
  final String cautionaryStatement;
  final int currentAqi;
  final int lowRange;
  final int highRange;
  final Color themeColor;

  const AQIScaleItem({
    super.key,
    required this.stateIcon,
    required this.title,
    required this.rangeStr,
    required this.healthImplications,
    required this.cautionaryStatement,
    required this.currentAqi,
    required this.lowRange,
    required this.highRange,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentRange = currentAqi >= lowRange && currentAqi <= highRange;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: isCurrentRange ? Border.all(color: themeColor, width: 2) : null,
        borderRadius: BorderRadius.circular(15),
        // Sử dụng .withValues chuẩn Flutter mới thay vì .withOpacity đã lỗi thời
        color: isCurrentRange ? themeColor.withValues(alpha: 0.08) : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stateIcon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "SF Pro Display", fontSize: 16, color: themeColor),
                      ),
                    ),
                    if (isCurrentRange)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: themeColor, borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Current",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      )
                  ],
                ),
                Text(
                  "AQI Range: $rangeStr",
                  style: const TextStyle(fontFamily: "ABeeZee", fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const Divider(height: 10, thickness: 0.5),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontFamily: "ABeeZee", fontSize: 12, color: Colors.black54),
                    children: [
                      const TextSpan(text: "Health Implications: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: healthImplications),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontFamily: "ABeeZee", fontSize: 12, color: Colors.black54),
                    children: [
                      const TextSpan(text: "Cautionary (PM2.5): ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)),
                      TextSpan(text: cautionaryStatement),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}