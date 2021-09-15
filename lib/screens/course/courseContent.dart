import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseIntroduction extends StatelessWidget {
  const CourseIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView(
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
            margin: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Course Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik-Medium',
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 3, right: 10),
                    height: 25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          "assets/icons/clock.svg",
                          color: Color(0xff78746D),
                          width: 20,
                          height: 20,
                        ),
                      ),
                      Text(
                        "3 hours, 3 min",
                        style: TextStyle(
                          color: Color(0xff78746D),
                          fontFamily: 'Rubik',
                          fontSize: 12,
                        ),
                      ),
                    ]))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                CourseTopicItem(
                  title: "This is a little",
                  subtitle:
                      "This is a subtitle ro some description about the course",
                  isFinished: true,
                  press: () => seeTopic(context, ""),
                ),
                CourseTopicItem(
                  title: "This is a little",
                  subtitle:
                      "This is a subtitle ro some description about the course",
                  isFinished: false,
                  press: () => seeTopic(context, ""),
                ),
                CourseTopicItem(
                  title: "This is a little",
                  subtitle:
                      "This is a subtitle ro some description about the course",
                  isFinished: false,
                  press: () => seeTopic(context, ""),
                ),
                CourseTopicItem(
                  title: "This is a little",
                  subtitle:
                      "This is a subtitle ro some description about the course",
                  isFinished: true,
                  press: () => seeTopic(context, ""),
                ),
                CourseTopicItem(
                  title: "This is a little",
                  subtitle:
                      "This is a subtitle ro some description about the course",
                  isFinished: false,
                  press: () => seeTopic(context, ""),
                ),
                CourseTopicItem(
                  title: "This is a little",
                  subtitle:
                      "This is a subtitle ro some description about the course",
                  isFinished: false,
                  press: () => seeTopic(context, ""),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void seeTopic(context, dynamic topic) {
    Navigator.pushNamed(context, "courseLesson");
  }
}

class CourseTopicItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final String? subtitle;
  final VoidCallback? press;
  final bool? isFinished;

  const CourseTopicItem(
      {Key? key,
      this.title,
      this.icon,
      this.press,
      this.subtitle,
      this.isFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  width: size.width * 0.60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 3),
                        child: Text(title!,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik-Medium",
                                fontSize: 16)),
                      ),
                      Container(
                        child: Text(subtitle!,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik-Medium",
                                fontSize: 13)),
                      ),
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
