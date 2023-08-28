import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tpte_03/features/on_boarding/mobx/home_page_mobx.dart';
import 'widgets/navigation_buttons.dart';
import 'widgets/navigation_indicators.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final PageController _pageViewController = PageController();

  final _homePageMobx = HomePageMobx();

  final List<Widget> _pages = [
    const Center(
      child: Text('Page1'),
    ),
    const Center(
      child: Text('Page2'),
    ),
    const Center(
      child: Text("Page3"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Observer(builder: (_) {
            return PageView(
              controller: _pageViewController,
              children: _pages,
              onPageChanged: (value) {
                _homePageMobx.newCurrentPage = value;
              },
            );
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Observer(builder: (_) {
                return Indicators(
                    totalPages: _pages.length,
                    selectedPage: _homePageMobx.currentPage);
              }),
              Observer(builder: (_) {
                return NavigationButtons(
                    selectedPage: _homePageMobx.currentPage,
                    pageController: _pageViewController);
              })
            ],
          ),
        ],
      ),
    );
  }
}
