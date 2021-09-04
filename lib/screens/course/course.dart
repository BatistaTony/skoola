import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skoola/components/simpleAppBar.dart';

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  int tab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Teste here").build(context),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "React Advanced Course with firebase",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik-Medium',
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  CourseTopBar(tab: tab, press: switchTab),
                  CourseIntroduction()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void switchTab(value) {
    setState(() {
      tab = value;
    });
  }
}

class CourseIntroduction extends StatelessWidget {
  const CourseIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text =
        "You can launch a new career in web develop-ment today by learning HTML & CSS. You don't need a computer science degree or expensive software. All you need is a computer, a bit of time, a lot of determination, and a teacher you trust.";

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
              height: 230,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/cover.png",
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: Text(
              "Introduction",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik-Medium',
                fontSize: 25,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                ProfileTopicItem(
                  title: "This is a little",
                  subtitle: "This is a subtitle",
                  isFinished: true,
                  press: () => seeTopic,
                ),
                ProfileTopicItem(
                  title: "This is a little",
                  subtitle: "This is a subtitle",
                  isFinished: false,
                  press: () => seeTopic,
                ),
                ProfileTopicItem(
                  title: "This is a little",
                  subtitle: "This is a subtitle",
                  isFinished: false,
                  press: () => seeTopic,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void seeTopic(dynamic topic) {}
}

class CourseTopBar extends StatelessWidget {
  final int? tab;
  final Function(int)? press;
  const CourseTopBar({Key? key, this.tab, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          CourseBarItem(
            side: "left",
            title: "LESSONS",
            isActive: tab == 1,
            press: () => press!(1),
          ),
          Container(
            width: 1,
            color: Colors.transparent,
          ),
          CourseBarItem(
              title: "TESTS", isActive: tab == 2, press: () => press!(2)),
          Container(
            width: 1,
            color: Colors.transparent,
          ),
          CourseBarItem(
              side: "right",
              isActive: tab == 3,
              title: "PROJECTS",
              press: () => press!(3))
        ],
      ),
    );
  }
}

class CourseBarItem extends StatelessWidget {
  final VoidCallback? press;
  final bool? isActive;
  final String? title;
  final String? side;

  const CourseBarItem(
      {Key? key, this.press, this.title, this.isActive, this.side})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isActive ?? false ? Color(0xffF9F9F9) : Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(side == "right" ? 20 : 0),
                  bottomRight: Radius.circular(side == "right" ? 20 : 0),
                  topLeft: Radius.circular(side == "left" ? 20 : 0),
                  bottomLeft: Radius.circular(side == "left" ? 20 : 0))),
          child: Text(
            title ?? "",
            style: TextStyle(
              color: Colors.black,
              fontFamily: isActive ?? false ? 'Rubik-Medium' : 'Rubik',
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTopicItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final String? subtitle;
  final VoidCallback? press;
  final bool? isFinished;

  const ProfileTopicItem(
      {Key? key,
      this.title,
      this.icon,
      this.press,
      this.subtitle,
      this.isFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffCCCCCC), width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isFinished ?? false
                            ? Color(0xff0079F1)
                            : Color(0xff3F3D56),
                        borderRadius: BorderRadius.circular(100)),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          "assets/icons/check.svg",
                          color: isFinished ?? false
                              ? Colors.white
                              : Color(0xff222140),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("this is a title",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Rubik-Medium",
                              fontSize: 14)),
                      Text("This is a subtitle",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Rubik-Medium",
                              fontSize: 13)),
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              width: 35,
              height: 35,
              padding: EdgeInsets.all(1),
              child: SvgPicture.asset(
                "assets/icons/play.svg",
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
