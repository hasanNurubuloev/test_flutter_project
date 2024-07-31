import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/goods/data/goods_data.dart';
import 'package:test_flutter_project/goods/presention/adding_goods_screen.dart';
import 'package:test_flutter_project/home/presentation/home_screen.dart';
import 'package:test_flutter_project/main/presentation/main_screen.dart';
import 'package:test_flutter_project/on_boarding/presentation/on_boarding.dart';
import 'package:test_flutter_project/registration/registration_screen.dart';

enum AppRoute {
  main,
  onBoarding,
  registration,
  home,
  addGoods,
}

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/main/presentation',
    routes: <RouteBase>[
      GoRoute(
        path: '/main/presentation',
        name: AppRoute.main.name,
        builder: (context, state){
          return const MainScreen();
        }
      ),
      GoRoute(
        path: '/home/presentation',
        name: AppRoute.home.name,
        builder: (context, state){
          return const HomeScreen();
        }
      ),
      GoRoute(
          path: '/goods/presentation',
          name: AppRoute.addGoods.name,
          builder: (context, state){
            if(state.extra == null) {
              return const AddingGoodsScreen();
            }else{
              print('add extraaaaa ${state.extra}');
              return AddingGoodsScreen(goodData: state.extra as GoodsData, status: 'update');
            }
          }
      ),

      GoRoute(
        path: '/on_boarding/presentation',
        name: AppRoute.onBoarding.name,
        builder: (context, state){
          return  OnBoardingScreen();
        }
      ),
      GoRoute(
        path: '/registration/presentation',
        name: AppRoute.registration.name,
        builder: (context, state){
          return  RegistrationScreen();
        }
      ),
    ],
  );
}
