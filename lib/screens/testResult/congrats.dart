import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/screens/home/home.dart';

class Congrats extends StatelessWidget {
  const Congrats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 300,
                child: SvgPicture.asset("assets/images/congrats.svg"),
              ),
              Container(
                child: Text(
                  "Congratulations, you budget your skill !",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Rubik-Medium',
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Let’s put your memory on this topic test. Solve tasks and check your knowledge.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Rubik',
                      fontSize: 17,
                    ),
                  )),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 60),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: ButtonApp(
                      press: null,
                      title: "Go home",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void backToHome(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ),
      (route) => false,
    );
  }
}
