import 'package:flutter/material.dart';

class OBColaboratorPage extends StatelessWidget {
  const OBColaboratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Collaboration",
          style: TextStyle(fontSize: 40),
        ),
        Image.asset(
          "assets/images/employee.png",
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Collaborate with people all over the wolrd!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
