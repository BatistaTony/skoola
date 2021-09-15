import 'package:skoola/screens/course/course.dart';
import 'package:skoola/screens/courseLesson/courseLesson.dart';
import 'package:skoola/screens/coursePreview/coursePreview.dart';
import 'package:skoola/screens/courseTest/courseTest.dart';
import 'package:skoola/screens/home/home.dart';
import 'package:skoola/screens/intro/intro.dart';
import 'package:skoola/screens/login/login.dart';
import 'package:skoola/screens/myCourses/myCourses.dart';
import 'package:skoola/screens/payment/payment.dart';
import 'package:skoola/screens/profile/profile.dart';
import 'package:skoola/screens/savedCourses/savedCourses.dart';
import 'package:skoola/screens/settings/settings.dart';
import 'package:skoola/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:skoola/screens/testResult/congrats.dart';
import 'package:skoola/screens/testResult/failed.dart';

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
      home: Intro(),
      routes: {
        "": (context) => const Intro(),
        "home": (context) => const Home(),
        "login": (context) => const Login(),
        "signup": (context) => const SignUp(),
        "coursePreview": (context) => const CoursePreview(),
        "profile": (context) => const Profile(),
        "course": (context) => const Course(),
        "myCourses": (context) => const MyCourses(),
        "settings": (context) => const Settings(),
        "payment": (context) => const Payment(),
        "courseLesson": (context) => const CourseLesson(),
        "savedCourses": (context) => const SavedCourses(),
        "courseTest": (context) => const CourseTest(),
        "congrats": (context) => const Congrats(),
        "failedTest": (context) => const FailedTest()
      },
    );
  }
}
