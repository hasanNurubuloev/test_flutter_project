import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/main/bloc/main_bloc.dart';
import 'package:test_flutter_project/router.dart';

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
    final router = goRouter();

    return BlocProvider<MainBloc>(
      create: (BuildContext context) {
        return MainBloc()..add(MainEvent(true));
      },
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff102DC6)),
        ),
        title: 'Flutter Test',
      ),
    );
  }
}
