import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/models/data.dart';
import 'package:skoola/screens/home/home.dart';
import 'package:skoola/screens/login/login.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';
import 'data.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int introScreen = 1;
  final _formsPageViewController = PageController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => checkIsLogged(context));
  }

  void checkIsLogged(context) async {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    var isAlreadyOnState = store.state.user?.id;

    var users = firebaseDb.collection("users");
    var isLogged = firebaseAuth.currentUser?.email;

    if (isLogged != null) {
      try {
        var user = (await users.doc(isLogged).get());
        Map<String, dynamic> userObj = user.data() as Map<String, dynamic>;

        if (isAlreadyOnState != null) {
          goToHomeCourses();
        } else {
          UserEntity userState =
              new UserEntity(user.id, "", "Angola", isLogged, userObj["name"]);
          store.dispatch(SetUser(userState));
          goToHomeCourses();
        }
      } catch (err) {
        print("something goes wrong !");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
              onTap: () => skipIntro(),
              child: Container(
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Text(
                  "skip",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Rubik-SemiBold'),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 390,
                  child: PageView.builder(
                      controller: _formsPageViewController,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ContentIntro(
                          content: introDatas[index],
                        );
                      }),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.center,
                    child: PaginationIntro(
                      introScreenNum: introScreen,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 80),
                    child: ButtonApp(title: "Next", press: () => nextScreen())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      ),
      (route) => false,
    );
  }

  void skipIntro() {
    goToHome();
  }

  void goToHomeCourses() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (route) => false,
    );
  }

  void nextScreen() {
    if (introScreen <= 2) {
      _formsPageViewController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInCubic,
      );
      setState(() {
        introScreen = introScreen + 1;
      });
    } else {
      goToHome();
    }
  }
}

class ContentIntro extends StatelessWidget {
  final IntroData? content;
  const ContentIntro({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width,
                height: 260,
                child: Image.asset(
                  content!.image ?? "assets/images/illustration.png",
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  content!.title ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik-Bold',
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  content!.description ?? "",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontFamily: 'Rubik-Bold',
                      fontSize: 14,
                      height: 1.3),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PaginationIntro extends StatelessWidget {
  final int? introScreenNum;
  const PaginationIntro({Key? key, this.introScreenNum = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PaginationDot(isSelected: introScreenNum == 1),
        PaginationDot(isSelected: introScreenNum == 2),
        PaginationDot(isSelected: introScreenNum == 3)
      ],
    );
  }
}

class PaginationDot extends StatelessWidget {
  final bool? isSelected;
  const PaginationDot({Key? key, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _duration = 1;
    return AnimatedContainer(
        duration: new Duration(seconds: _duration.toInt()),
        width: isSelected ?? false ? 16 : 6,
        height: 6,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: isSelected ?? false ? Color(0xff65AAEA) : Color(0xffD5D4D4),
            borderRadius: BorderRadius.circular(100)));
  }
}
