import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/goods/data/goods_data.dart';

class AddingGoodsScreen extends StatefulWidget {
  final GoodsData? goodData;
  final String? status;

  const AddingGoodsScreen({super.key, this.goodData, this.status});

  @override
  State<AddingGoodsScreen> createState() => _AddingGoodsScreenState();
}

class _AddingGoodsScreenState extends State<AddingGoodsScreen> {
  final _fieldTextGoods = TextEditingController();
  final _fieldTextPrice = TextEditingController();
  bool _validateGoods = false;
  bool _validatePrice = false;

  @override
  void initState() {
    _fieldTextGoods.text = widget.goodData?.good ?? '';
    _fieldTextPrice.text = widget.goodData?.price ?? '';
    super.initState();
  }

  String validateGoods(String goodsText) {
    if (goodsText.isEmpty) {
      return 'Enter good';
    } else if (!RegExp(r'^[a-z]+$').hasMatch(goodsText)) {
      return 'The good must contain letter';
    } else {
      return '';
    }
  }

  String validatePrice(String priceText) {
    if (priceText.isEmpty) {
      return 'Enter price';
    } else if (int.tryParse(priceText) != null) {
      return 'The price must contain numeric';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Add goods',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(60),
        child: Column(
          children: [
            TextField(
              controller: _fieldTextGoods,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _fieldTextGoods.clear),
                  labelText: 'Goods',
                  errorText: _validateGoods
                      ? validateGoods(_fieldTextGoods.text)
                      : null),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _fieldTextPrice,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _fieldTextPrice.clear),
                  labelText: 'Price',
                  errorText: _validatePrice
                      ? validatePrice(_fieldTextPrice.text)
                      : null),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 50,
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    if (widget.status == 'update') {
                      context.pop(GoodsData(
                          good: _fieldTextGoods.text,
                          price: _fieldTextPrice.text));
                    } else if (_fieldTextGoods.text.isNotEmpty &&
                        _fieldTextPrice.text.isNotEmpty &&
                        RegExp(r'^[a-z A-Z 0-9]+$')
                            .hasMatch(_fieldTextGoods.text) &&
                        RegExp(r'^[0-9]+$').hasMatch(_fieldTextPrice.text)) {
                      DateTime time = DateTime.now();

                      context.pop(GoodsData(
                          good: _fieldTextGoods.text,
                          price: _fieldTextPrice.text,
                          dateTime:
                              '${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')}.${time.year}'));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).appBarTheme.backgroundColor),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
