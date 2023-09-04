import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
          backgroundColor: Colors.brown,
          shadowColor: const Color.fromARGB(255, 255, 255, 176)),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Colors.brown,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 176),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            )
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: ElevatedButton(
            style: const ButtonStyle(
              side: MaterialStatePropertyAll(BorderSide(
                  width: 2.0, color: Color.fromARGB(255, 255, 255, 176))),
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.brown),
            ),
            child: const Text(
              "add book",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 176)),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
