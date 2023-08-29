import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../homepage/home_page.dart';
import '../mobx/home_page_mobx.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _homePageMobx = HomePageMobx();

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value!.isEmpty || !regex.hasMatch(value)) {
      _homePageMobx.newValidEmail = false;
      return 'Enter a valid email address';
    }
    _homePageMobx.newValidEmail = true;
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      _homePageMobx.newValidPassword = false;
      return 'Enter a valid password';
    }
    _homePageMobx.newValidPassword = true;
    return null;
  }

  _accessNextPage(BuildContext context) {
    if (_homePageMobx.validPassword && _homePageMobx.validEmail) {
      return () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height * .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "Email",
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: validatePassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                ),
                Observer(builder: (context) {
                  return Row(
                    children: [
                      Checkbox(
                        value: _homePageMobx.remeberUser,
                        onChanged: (value) {
                          print(_homePageMobx.remeberUser);
                          _homePageMobx.newRemeberUser = value!;
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  );
                }),
                Observer(builder: (context) {
                  return ElevatedButton(
                      onPressed: _accessNextPage(context),
                      child: const Text("Sign in"));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
