import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/home/components/home_header.dart';
import 'package:kucing_otomatis/screens/smart/components/device.dart';

class SmartScreen extends StatelessWidget {
  static String routeName = "/home";

  const SmartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffB59AD7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [HomeHeader(), SizedBox(height: 5), DeviceInfoGrid()],
          ),
        ),
      ),
    );
  }
}
