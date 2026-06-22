import 'package:url_launcher/url_launcher.dart';

class DataBankService {
  Future<bool> sendDataRequest({
    required String userEmail,
    required String location,
    required String formattedDate,
  }) async {
    const String adminEmail = "huynhmanh999@gmail.com";
    final String subject = Uri.encodeComponent("Request for AQI Pollutant Data - $location");
    final String body = Uri.encodeComponent(
      "Hello Admin,\n\n"
      "I would like to place a request for downloading pollutant data with the following details:\n"
      "- User Contact Email: $userEmail\n"
      "- Requested Location: $location\n"
      "- Date of Interest: $formattedDate\n\n"
      "Please share the AQI data along with the link to the Live Emission Visualiser Dashboard.\n\n"
      "Thank you,\n"
      "$userEmail"
    );

    final Uri emailUri = Uri.parse("mailto:$adminEmail?subject=$subject&body=$body");

    if (await canLaunchUrl(emailUri)) {
      return await launchUrl(emailUri);
    } else {
      throw "Could not launch email app";
    }
  }
}