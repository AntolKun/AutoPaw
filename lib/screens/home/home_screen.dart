import 'package:flutter/material.dart';
import 'package:kucing_otomatis/screens/home/components/cat_home.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffB59AD7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: 5),
              CatInfoGrid()
            ],
          ),
        ),
      ),
    );
  }
}
