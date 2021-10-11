import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:skoola/models/data.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:skoola/store/app_state.dart';
import 'package:skoola/store/reducers/user.dart';

Future<void> main() async {
  final UserEntity userState = new UserEntity("", "", "", "", "");
  final _initialState = AppState(userState);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
  // This widget is the root of your application.

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'skoola',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xff222140),
            fontFamily: 'Rubik',
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
            future: firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("there is a error ===> " + snapshot.error.toString());
                return Container(
                    child:
                        Center(child: Text("Something wrong with firebase")));
              } else if (snapshot.hasData) {
                print("connected sucessfully !");
                return Intro();
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          // home: Intro(),
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
        ));
  }
}
