import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';
import 'package:skoola/screens/course/courseContent.dart';
import 'package:skoola/screens/course/courseTests.dart';

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  int tab = 1;
  final _formsPageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    var titles = ["Lessons", "Tests", "Projects"];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SimpleAppBar(title: titles[tab - 1]).build(context),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "React Advanced Course with firebase",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik-Medium',
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                CourseTopBar(tab: tab, press: switchTab),
                // CourseIntroduction()
                Container(
                  height: size.height * 0.66,
                  child: PageView.builder(
                      allowImplicitScrolling: true,
                      controller: _formsPageViewController,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        switch (tab) {
                          case 1:
                            {
                              return CourseIntroduction();
                            }

                          case 2:
                            {
                              return CourseTests();
                            }

                          case 3:
                            {
                              return CourseIntroduction();
                            }

                          default:
                            {
                              return CourseIntroduction();
                            }
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void switchTab(value) {
    _formsPageViewController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
    );

    setState(() {
      tab = value;
    });
  }
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
            title: "LESSONS (15)",
            isActive: tab == 1,
            press: () => tab != 1 ? press!(1) : null,
          ),
          Container(
            width: 1,
            color: Colors.transparent,
          ),
          CourseBarItem(
              title: "TESTS",
              isActive: tab == 2,
              press: () => tab != 2 ? press!(2) : null),
          Container(
            width: 1,
            color: Colors.transparent,
          ),
          CourseBarItem(
              side: "right",
              isActive: tab == 3,
              title: "PROJECTS",
              press: () => tab != 3 ? press!(3) : null)
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
