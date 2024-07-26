import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/goods/bloc/goods_bloc.dart     ';
import 'package:test_flutter_project/goods/goods_data.dart';

class AddingGoods extends StatefulWidget {
  final GoodsData? goodData;
  final String? status;

  const AddingGoods({super.key, this.goodData, this.status});

  @override
  State<AddingGoods> createState() => _AddingGoodsState();
}

class _AddingGoodsState extends State<AddingGoods> {
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
    return BlocProvider<GoodsBloc>(
      create: (context) => GoodsBloc(),
      child: BlocConsumer<GoodsBloc, GoodsData>(
        listener: (BuildContext context, GoodsData state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Add goods',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue[500],
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
                            Navigator.pop(
                                context,
                                GoodsData(
                                    good: _fieldTextGoods.text,
                                    price: _fieldTextPrice.text));
                          } else if (_fieldTextGoods.text.isNotEmpty &&
                              _fieldTextPrice.text.isNotEmpty &&
                              RegExp(r'^[a-z]+$')
                                  .hasMatch(_fieldTextGoods.text)) {
                            Navigator.pop(
                                context,
                                GoodsData(
                                    good: _fieldTextGoods.text,
                                    price: _fieldTextPrice.text));
                            print(
                                'Goods contains letters and price contains only numeric');
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blue[500]!),
                          foregroundColor:
                              const WidgetStatePropertyAll(Colors.white),
                        ),
                        child: const Text('Save')),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
