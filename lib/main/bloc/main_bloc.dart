import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/services/injection.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(null)) {
    on<MainEvent>(_onGetOnboarding);
  }

  void _onGetOnboarding(MainEvent event, Emitter<MainState> emit) async {
    SharedPreferences prefs = getIt<SharedPreferences>();
    bool onBoarding = prefs.getBool('isOnBoardingShown') ?? false;
    emit(MainState(onBoarding));
  }
}

class MainEvent {
  bool? onBoardingShown;

  MainEvent(this.onBoardingShown);

}

class MainState {
  bool? onBoardingShown;

  MainState(this.onBoardingShown);
}
