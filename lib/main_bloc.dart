import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(null)) {
    on<MainEvent>(_onGetOnboarding);
  }

  void _onGetOnboarding(MainEvent event, Emitter<MainState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onBoarding = prefs.getBool('isOnBoardingShown') ?? false;
    emit(MainState(onBoarding));
  }
}

class MainEvent {}

class MainState {
  bool? onBoardingShown;

  MainState(this.onBoardingShown);
}
