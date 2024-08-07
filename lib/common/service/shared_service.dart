
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/goods/data/goods_data.dart';

@singleton
class SharedService {

  final SharedPreferences _prefs;
  static const String _listGoodsDataKey = 'listGoodsData';


  SharedService(this._prefs);

  List<GoodsData> getListGoods (){
    final listGoodsData = _prefs.getStringList(_listGoodsDataKey) ?? [];
    return  listGoodsData.map((e) => GoodsData.fromJson(jsonDecode(e))).toList();
  }

  Future<void> setListGoods(GoodsData goodsData) async {
    List<GoodsData> list = getListGoods()..add(goodsData);
    // await _prefs.setStringList(HomeScreen.listGoodsDataKey, list.map((e) => GoodsData.fromJson(jsonEncode(e))).toList());
  }

}