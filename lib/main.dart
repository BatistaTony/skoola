import 'package:skoola/screens/home/home.dart';
import 'package:skoola/screens/intro/intro.dart';
import 'package:skoola/screens/login/login.dart';
import 'package:skoola/screens/signup/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'skoola',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff222140),
        fontFamily: 'Rubik',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      home: Intro(),
      routes: {
        "": (context) => const Intro(),
        "home": (context) => const Home(),
        "login": (context) => const Login(),
        "signup": (context) => const SignUp()
      },
    );
  }
}
