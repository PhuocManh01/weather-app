import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/data_bank_page/bloc/data_bank_bloc.dart';
import 'package:weather_app/features/data_bank_page/bloc/data_bank_event.dart';
import 'package:weather_app/features/data_bank_page/bloc/data_bank_state.dart';

class DataBankPage extends StatefulWidget {
  const DataBankPage({super.key});

  @override
  State<DataBankPage> createState() => _DataBankPageState();
}

class _DataBankPageState extends State<DataBankPage> {
  // 1. Bộ điều khiển nhập liệu và biến lưu ngày chọn
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // Hàm xử lý đẩy event khi bấm nút gửi dữ liệu
  void _onSubmit() {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    context.read<DataBankBloc>().add(
      SubmitDataRequest(
        userEmail: _emailController.text.trim(),
        location: _locationController.text.trim(),
        formattedDate: formattedDate,
      ),
    );
  }

  // Hàm hiển thị SnackBar thông báo nhanh
  void _showSnackBar(String message, Color bgColor, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataBankBloc, DataBankState>(
      listener: (context, state) {
        if (state is DataBankSuccess) {
          _showSnackBar("Request forwarded to your email app!", Colors.green, Icons.check_circle);
        } else if (state is DataBankFailure) {
          _showSnackBar(state.error, Colors.red, Icons.error);
        }
      },
      child: Scaffold(
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
                const SizedBox(height: 10),
                const Text(
                  "Request for Data",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SF Pro Display",
                  ),
                ),
                const Text(
                  "If you would like to download pollutant data, please place your request here. We’ll share the AQI data along with a link to the Live Emission Visualiser - Data Bank dashboard.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontFamily: "ABeeZee",
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                // Ô nhập Email
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: "user@email.com",
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                ),
                const SizedBox(height: 10),
                // Ô nhập Vị trí
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: "Location",
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                ),
                const SizedBox(height: 10),
                // Chọn ngày
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  onDateChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 10),
              
                BlocBuilder<DataBankBloc, DataBankState>(
                  builder: (context, state) {
                    if (state is DataBankLoading) {
                      return const Center(child: CircularProgressIndicator(color: Colors.green));
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        onPressed: _onSubmit,
                        child: const Text("Make Request", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}