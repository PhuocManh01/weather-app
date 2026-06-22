import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  // Helper xử lý cuộc gọi trực tiếp
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(' ', ''),
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  // Helper xử lý mở trình soạn email
  Future<void> _openEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    const String supportEmail = "admin@example.com";
    const String hotlineNumber = "0987 456 321";

    return Scaffold(
      backgroundColor: Colors.grey[100], // Màu nền xám nhẹ đồng bộ toàn hệ thống
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Contact Us",
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
            
            // 🎧 Khung chứa Icon Support mặc định tinh tế (Giống Avatar Profile)
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
                Icons.headset_mic_rounded,
                size: 55,
                color: Colors.green,
              ),
            ),
            
            const SizedBox(height: 32),

            // 🪪 Khối hiển thị thông tin liên hệ (Bọc trong Card trắng tương tự Profile)
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
                spacing: 16, // Đồng bộ Spacing toàn cục mới
                children: [
                  // Dòng Email Support (Có thể click để mở ứng dụng mail)
                  InkWell(
                    onTap: () => _openEmail(supportEmail),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        const Icon(Icons.mail_outline_rounded, color: Colors.grey, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email Support",
                                style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "ABeeZee"),
                              ),
                              Text(
                                supportEmail,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "SF Pro Display"),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.black26),
                      ],
                    ),
                  ),

                  const Divider(height: 1, thickness: 0.5, color: Colors.black12),

                  // Dòng Hotline (Có thể click để gọi điện)
                  InkWell(
                    onTap: () => _makePhoneCall(hotlineNumber),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_android_rounded, color: Colors.grey, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hotline",
                                style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "ABeeZee"),
                              ),
                              Text(
                                hotlineNumber,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "SF Pro Display", color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.black26),
                      ],
                    ),
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