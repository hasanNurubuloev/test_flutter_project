import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/goods/goods_data.dart';
import 'package:test_flutter_project/main.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsData> {
  // GoodsBloc(super.initialState){
  // }
  GoodsBloc() : super(GoodsData(good: 'goo', price: '20')) {
    on<GoodsEvent>(_onUpdateGoods);
  }

  Future<void> _onUpdateGoods(GoodsEvent event, Emitter<GoodsData> emit) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(MyApp.goodsKey, jsonEncode(GoodsData(good: event.good, price: event.price)));
    emit(GoodsData(good: event.good, price: event.price));
  }


}

class GoodsEvent {
  String? good;
  String? price;

  GoodsEvent(this.good, this.price);
}
