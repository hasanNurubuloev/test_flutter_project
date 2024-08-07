import 'package:injectable/injectable.dart';

@injectable
class TimerService {
  int _timerValue = 60;


  int getTimerValue() {
    return _timerValue;
  }

  void setTimerValue(int timerValue) {
    _timerValue = timerValue;
  }
}
