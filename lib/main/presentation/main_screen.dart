import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/main/bloc/main_bloc.dart';
import 'package:test_flutter_project/on_boarding/presentation/on_boarding.dart';
import 'package:test_flutter_project/registration/registration_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg'
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state.onBoardingShown == true) {
        return RegistrationScreen();
      } else {
        return OnBoardingScreen();
      }
    });
  }
}
