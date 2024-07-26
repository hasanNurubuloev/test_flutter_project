import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/main_bloc.dart';
import 'package:test_flutter_project/presentation/on_boarding.dart';
import 'package:test_flutter_project/presentation/registration_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const goodsKey = 'goods';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg'
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (BuildContext context) {
        return MainBloc()..add(MainEvent());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Test',
        home: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state.onBoardingShown == true) {
              return RegistrationScreen();
            } else {
              return OnBoarding();
            }
          },
        ),
      ),
    );
  }
}
