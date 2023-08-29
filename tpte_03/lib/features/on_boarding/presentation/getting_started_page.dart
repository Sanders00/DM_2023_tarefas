import 'package:flutter/material.dart';
import 'package:tpte_03/features/login/presentation/login_page.dart';

class OBGettingStartedPage extends StatelessWidget {
  const OBGettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Become one of us!",
          style: TextStyle(fontSize: 35),
        ),
        Image.asset(
          "assets/images/start.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: const Text(
              "Get Started",
              style: TextStyle(fontSize: 30),
            ))
      ],
    );
  }
}
