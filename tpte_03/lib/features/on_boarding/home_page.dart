import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tpte_03/features/on_boarding/mobx/home_page_mobx.dart';
import 'package:tpte_03/features/on_boarding/presentation/welcome_page.dart';
import 'presentation/colaborator_page.dart';
import 'presentation/getting_started_page.dart';
import 'widgets/navigation_indicators.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final PageController _pageViewController = PageController();

  final _homePageMobx = HomePageMobx();

  final List<Widget> _pages = [
    const OBWelcomePage(),
    const OBColaboratorPage(),
    const OBGettingStartedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageViewController,
            children: _pages,
            onPageChanged: (value) {
              _homePageMobx.newCurrentPage = value;
            },
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Observer(builder: (_) {
              return Visibility(
                visible: _homePageMobx.currentPage != _pages.length - 1,
                child: TextButton(
                    onPressed: () {
                      _pageViewController.animateToPage(_pages.length,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: const Text("Skip")),
              );
            }),
            Observer(builder: (_) {
              return Indicators(
                  totalPages: _pages.length,
                  selectedPage: _homePageMobx.currentPage);
            }),
            Observer(builder: (_) {
              return Visibility(
                visible: _homePageMobx.currentPage != _pages.length - 1,
                child: TextButton(
                    onPressed: () {
                      _pageViewController.animateToPage(
                          _homePageMobx.currentPage + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: const Text("Next")),
              );
            })
          ],
        ),
      ),
    );
  }
}
