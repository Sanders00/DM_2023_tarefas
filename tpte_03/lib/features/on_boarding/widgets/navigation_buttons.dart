import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final int selectedPage;
  final PageController pageController;

  const NavigationButtons(
      {super.key, required this.selectedPage, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (selectedPage > 0)
          FloatingActionButton(
            onPressed: () => pageController.animateToPage(
              (selectedPage - 1),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            ),
            child: const Icon(Icons.arrow_back_rounded),
          ),
        //if (selectedPage == 0) const Spacer(),
        Visibility(
          visible: (selectedPage < 2),
          child: FloatingActionButton(
            onPressed: () => pageController.animateToPage(
              (selectedPage + 1),
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
            ),
            child: const Icon(Icons.arrow_forward_rounded),
          ),
        ),
      ],
    );
  }
}
