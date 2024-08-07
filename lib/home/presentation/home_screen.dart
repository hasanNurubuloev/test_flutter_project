
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/service/shared_service.dart';
import 'package:test_flutter_project/goods/data/goods_data.dart';
import 'package:test_flutter_project/home/bloc/home_bloc.dart';
import 'package:test_flutter_project/router.dart';
import 'package:test_flutter_project/services/injection.dart';

class HomeScreen extends StatefulWidget {
  static const String listGoodsDataKey = 'listGoodsData';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<GoodsData> listGoodsData = [];



  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc(getIt<SharedService>(),HomeState(listGoodsData))..add(HomeGetEvent(listGoodsData)),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(onPressed:() => context.pushNamed(AppRoute.timer.name), child: const Text('Timer', style: TextStyle(color: Colors.white),))
              ],
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Color(0xff102DC6)),
              title: const Text(
                'Home Screen',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: state.goodsData?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context
                        .pushNamed(AppRoute.addGoods.name,
                            extra: GoodsData(
                              good: state.goodsData?[index].good,
                              price: state.goodsData?[index].price,
                              dateTime: state.goodsData?[index].dateTime,
                            ))
                        .then((val) {
                      state.goodsData?[index] = val as GoodsData;
                      context.read<HomeBloc>().add(HomeUpdateEvent(
                          state.goodsData?[index] ?? GoodsData(), index));
                    });
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text('Delete'),
                              content: const Text('Are you sure want delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop('Cancel');
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      context.pop('OK');
                                      context.read<HomeBloc>().add(
                                          HomeDeleteEvent(
                                              state.goodsData?[index] ??
                                                  GoodsData(),
                                              index));
                                      //TODO!!!!!!!!!!!!!!!

                                    },
                                    child: const Text('OK')),
                              ],
                            ));
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.goodsData?[index].dateTime ?? '',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4C4C4C),
                                fontSize: 25),
                          ),
                          const Divider()
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              state.goodsData?[index].good ?? '',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color(0xff102DC6),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              state.goodsData?[index].price ?? '',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Color(0xff102DC6),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              // backgroundColor: const Color(0xff102DC6),
              onPressed: () {
                context.pushNamed(AppRoute.addGoods.name).then((val) {
                  if (val != null && val is GoodsData) {
                    context.read<HomeBloc>().add(HomeSetEvent(val));
                  }
                });
              },
              shape: const CircleBorder(
                  side: BorderSide(
                color: const Color(0xff102DC6),
                width: 4,
              )),
              child: const Text(
                '+',
                style: TextStyle(
                    color: const Color(0xff102DC6),
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    backgroundColor: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
