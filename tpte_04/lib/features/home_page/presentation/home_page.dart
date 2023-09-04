import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 59, 48),
      body: const CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:  Color.fromARGB(255, 88, 59, 48),
            shadowColor:  Color.fromARGB(255, 255, 255, 176),
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title:  Text(
                "Library of Babel",
                style: TextStyle(
                    fontSize: 21,
                    color: Color.fromARGB(255, 255, 255, 176),
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Color.fromARGB(255, 255, 255, 176),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 88, 59, 48),
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
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 88, 59, 48)),
            ),
            child: const Text(
              "add book",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 176), fontSize: 20),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
