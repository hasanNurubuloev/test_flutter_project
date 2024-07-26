import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/goods/goods_data.dart';
import 'package:test_flutter_project/goods/presention/adding_goods_screen.dart';
import 'package:test_flutter_project/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  static final String listGoodsDataKey = 'listGoodsData';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GoodsData> listGoodsData = [
    GoodsData(good: 'go1', price: '20'),
    GoodsData(good: 'go2', price: '30'),
    GoodsData(good: 'go3', price: '40'),
  ];

  @override
  void initState() {
    // getGoodsPrefs();
    print('initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getPrefs();
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(HomeState(listGoodsData))..add(HomeGetEvent(listGoodsData)),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // context.read<HomeBloc>().add(HomeEvent(listGoodsData));
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Home Screen',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue[500],
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: state.goodsData?.length,
              itemBuilder: (BuildContext context, int index) {
                print('listGoods in home ${state.goodsData?.last.good}');
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddingGoods(goodData: state.goodsData?[index], status: 'update',))).then((val) {
                          state.goodsData?[index] = val;
                          context.read<HomeBloc>().add(HomeUpdateEvent(state.goodsData?[index] ?? GoodsData(), index));
                    });
                    print('${state.goodsData?.first.good}  ${state.goodsData?.first.price}');
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          state.goodsData?[index].good ?? '',
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          state.goodsData?[index].price ?? '',
                          style: const TextStyle(fontSize: 30),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue[500],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddingGoods()),
                ).then((val) {
                  if (val != null && val is GoodsData) {
                    context.read<HomeBloc>().add(HomeSetEvent(val));
                  }
                });
              },
              shape: const CircleBorder(),
              child: const Text(
                '+',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
