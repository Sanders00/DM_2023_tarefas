import 'package:flutter/material.dart';

class OBWelcomePage extends StatelessWidget {
  const OBWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "WELCOME!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        Image.asset(
          "assets/images/welcome.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        const Text(
          "Our Team Awaits You!",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
