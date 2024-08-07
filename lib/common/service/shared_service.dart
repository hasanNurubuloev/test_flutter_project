import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/goods/data/goods_data.dart';

@injectable
class SharedService {
  final SharedPreferences _prefs;
  static const String _listGoodsDataKey = 'listGoodsData';

  SharedService(this._prefs);

  List<GoodsData> getListGoods() {
    final listGoodsData = _prefs.getStringList(_listGoodsDataKey) ?? [];
    return listGoodsData.map((e) => GoodsData.fromJson(jsonDecode(e))).toList();
  }

  List<GoodsData> addListGoods(GoodsData goodsData) {
    List<GoodsData> list = getListGoods()..add(goodsData);
    _prefs.setStringList(
        _listGoodsDataKey, list.map((e) => jsonEncode(e)).toList());
    return list;
  }

  List<GoodsData> updateListGoods(
      List<GoodsData> listGoodsData, GoodsData goodsData, int index) {
    listGoodsData[index] = GoodsData(
        good: goodsData.good,
        price: goodsData.price,
        dateTime: goodsData.dateTime);
    _prefs.setStringList(
        _listGoodsDataKey, listGoodsData.map((e) => jsonEncode(e)).toList());

    return listGoodsData;
  }

  List<GoodsData> deleteListGoods(
      List<GoodsData> listGoodsData, GoodsData goodsData, int index) {
    listGoodsData.removeAt(index);
    _prefs.setStringList(
        _listGoodsDataKey, listGoodsData.map((e) => jsonEncode(e)).toList());

    return listGoodsData;
  }
}
