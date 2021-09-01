import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skoola/components/simpleAppBar.dart';

class CoursePreview extends StatelessWidget {
  const CoursePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var text =
        "You can launch a new career in web develop-ment today by learning HTML & CSS. You don't need a computer science degree or expensive software. All you need is a computer, a bit of time, a lot of determination, and a teacher you trust.";
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Reactjs course ",
      ).build(context),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    height: size.height * 0.30,
                    child: Image.asset(
                      "assets/images/cover.png",
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  bottom: 10.5,
                  right: 10.5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff0079F1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Text(
                        "\$45,54",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik-Medium',
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("About the course",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik-Medium',
                            fontSize: 24)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 14)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 14)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 14)),
                  ),
                  CourseTopicsOnPreview()
                ],
              ),
            ),
          ],
        )),
      ),
      floatingActionButton: GestureDetector(
        onTap: addCourse,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Color(0xff0079F1),
              borderRadius: BorderRadius.circular(100)),
          child: Container(
              padding: EdgeInsets.all(18),
              child: SvgPicture.asset("assets/icons/plus.svg")),
        ),
      ),
    );
  }

  void addCourse() {
    print("do something with course");
  }
}

class CourseTopicsOnPreview extends StatelessWidget {
  const CourseTopicsOnPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.topLeft,
          child: Text("Topics",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rubik-Medium',
                  fontSize: 24)),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              buildItemTopic("Getting Started"),
              buildItemTopic("Getting Started"),
              buildItemTopic("Getting Started"),
              buildItemTopic("Getting Started"),
              buildItemTopic("Getting Started")
            ],
          ),
        )
      ],
    );
  }

  Widget buildItemTopic(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff3F3D56), borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                width: 7,
                height: 7,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Rubik', fontSize: 17)),
            )
          ],
        ),
      ),
    );
  }
}
