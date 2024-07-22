import 'package:flutter/material.dart';
import 'package:test_flutter_project/screens/registration_screen.dart';
import 'package:test_flutter_project/screens/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  int _slideIndex = 0;

  final List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg'
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Test',
      home: FutureBuilder<bool>(
        future: _getOnBoardingStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == true) {
              return RegistrationScreen();
            } else {
              return OnBoarding();
            }
          }
        },
      ),
    );
  }
  Future<bool> _getOnBoardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOnBoardingShown') ?? false;
  }
}


