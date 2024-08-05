import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/goods/data/goods_data.dart';
import 'package:test_flutter_project/home/presentation/home_screen.dart';
import 'package:test_flutter_project/services/injection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<HomeGetEvent>(_onGetListGoods);
    on<HomeSetEvent>(_onSetListGoods);
    on<HomeUpdateEvent>(_onUpdateGoods);
    on<HomeDeleteEvent>(_onDeleteGoods);
  }

  Future<void> _onGetListGoods(
      HomeGetEvent event, Emitter<HomeState> emit) async {
    List<GoodsData> listData = [];
    var prefs = getIt<SharedPreferences>();
    final listGoodsData =
        prefs.getStringList(HomeScreen.listGoodsDataKey) ?? [];
    for (var goodData in listGoodsData) {
      listData.add(GoodsData.fromJson(jsonDecode(goodData)));
    }
    emit(HomeState(listData));
  }

  Future<void> _onSetListGoods(
      HomeSetEvent event, Emitter<HomeState> emit) async {
    List<String> listDataJson = [];
    var prefs = getIt<SharedPreferences>();
    state.goodsData?.add(event.goodsData);
    for (var e in state.goodsData ?? []) {
      listDataJson.add(jsonEncode(e));
    }
    prefs.setStringList(HomeScreen.listGoodsDataKey, listDataJson);
    emit(HomeState(state.goodsData));
  }

  Future<void> _onUpdateGoods(
      HomeUpdateEvent event, Emitter<HomeState> emit) async {
    List<String> listDataJson = [];
    var prefs = getIt<SharedPreferences>();
    state.goodsData?[event.index] = GoodsData(
        good: event.goodsData.good,
        price: event.goodsData.price,
        dateTime: event.goodsData.dateTime);
    for (var e in state.goodsData ?? []) {
      listDataJson.add(jsonEncode(e));
    }
    prefs.setStringList(HomeScreen.listGoodsDataKey, listDataJson);
    emit(HomeState(state.goodsData));
  }

  Future<void> _onDeleteGoods(
      HomeDeleteEvent event, Emitter<HomeState> emit) async {
    var prefs = getIt<SharedPreferences>();
    List<String> listDataJson = [];
    state.goodsData?.removeAt(event.index);

    for (var e in state.goodsData ?? []) {
      listDataJson.add(jsonEncode(e));
    }

    prefs.setStringList(HomeScreen.listGoodsDataKey, listDataJson);
    emit(HomeState(state.goodsData));
  }
}

abstract class HomeEvent {}

class HomeGetEvent extends HomeEvent {
  List<GoodsData>? goodsData;

  HomeGetEvent(this.goodsData);
}

class HomeSetEvent extends HomeEvent {
  GoodsData goodsData;

  HomeSetEvent(this.goodsData);
}

class HomeUpdateEvent extends HomeEvent {
  GoodsData goodsData;
  int index;

  HomeUpdateEvent(this.goodsData, this.index);
}

class HomeDeleteEvent extends HomeEvent {
  GoodsData goodsData;
  int index;

  HomeDeleteEvent(this.goodsData, this.index);
}

class HomeState {
  List<GoodsData>? goodsData;

  HomeState(this.goodsData);
}
