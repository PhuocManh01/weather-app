import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataBankPage extends StatefulWidget {
  const DataBankPage({super.key});

  @override
  State<DataBankPage> createState() => _DataBankPageState();
}

class _DataBankPageState extends State<DataBankPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset("assets/images/data_bank_page/data_bank_illustration.svg"),
                ),
              ),
              
              SizedBox(height: 10),
        
              Text(
                "Request for Data",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SF Pro Display"
                ),
                textAlign: TextAlign.left,
              ),
        
              Text("If you would like to download pollutant data, please place your request here. We’ll share the AQI data along with a link to the Live Emission Visualiser - Data Bank dashboard.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontFamily: "ABeeZee",
                  fontStyle: FontStyle.italic
                ),
              ),
        
              SizedBox(height: 10),
              
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: "user@email.com",
                  hintStyle : TextStyle(fontSize: 15, color: Colors.grey),
                  // border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                ),
              ),
        
              SizedBox(height: 10),
        
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: "Location",
                  hintStyle : TextStyle(fontSize: 15, color: Colors.grey),
                  // border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                ),
              ),
        
              SizedBox(height: 10),
        
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                onDateChanged: (date) {
                  // Handle date selection
                },
              ),
        
              SizedBox(height: 10),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                  ),
                  onPressed: _makeRequest,
                  child: Text("Make Request", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _makeRequest() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Text(
            "Request Sent!",
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Container(),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              
            }
          )
        ],
      ),
    ),
  );
  }
}