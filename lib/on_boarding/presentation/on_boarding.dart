import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/on_boarding/data/on_boarding_content.dart';
import 'package:test_flutter_project/router.dart';
import 'package:test_flutter_project/services/injection.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeOnBoarding() async {
    SharedPreferences prefs = getIt<SharedPreferences>();
    await prefs.setBool('isOnBoardingShown', true);
    context.goNamed(AppRoute.registration.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          if (currentIndex != contents.length - 1)
            TextButton(
              onPressed: _completeOnBoarding,
              child: const Text(
                'SKIP',
                style: TextStyle(color: Colors.black),
              ),
            )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(contents[i].image),
                        // fit: BoxFit.fill  ,
                      ),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  contents.length, (index) => buildDot(index, context)),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(30),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  _completeOnBoarding();
                  //  context.read<MainBloc>().add(MainEvent(true));
                  //  context.goNamed(AppRoute.registration.name);
                }
                _controller.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceInOut);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
              child: Text(
                  currentIndex == contents.length - 1 ? 'Continue' : 'Next'),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor),
    );
  }
}
