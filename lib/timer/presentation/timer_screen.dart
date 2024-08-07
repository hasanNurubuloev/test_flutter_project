import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_flutter_project/common/service/timer_service.dart';
import 'package:test_flutter_project/services/injection.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _timerValue = 0;


  void _startTimer() {
    _timerValue = getIt<TimerService>().getTimerValue();
    print('ololo');
    _timer != null
        ? _timer?.cancel()
        : _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            print('start $_timerValue');
            setState(() {
              _timerValue--;
            });
          });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _timer = null;
    getIt<TimerService>().setTimerValue(_timerValue);
    print('pause timerValue $_timerValue');
    print('pause getIt ${getIt<TimerService>().getTimerValue()}');
  }

  @override
  Widget build(BuildContext context) {
    // Textcontr
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _timerValue.toString(),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: _startTimer,
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).appBarTheme.backgroundColor)),
                child: const Text('Start timer',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: _pauseTimer,
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).appBarTheme.backgroundColor)),
                child: const Text('Pause timer',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
