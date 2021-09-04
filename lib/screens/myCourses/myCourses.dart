import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  int tab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "My courses",
      ).build(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwitchProgress(
                  changeTab: changeTab,
                  tab: tab,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 1000,
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "assets/images/cover.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    padding: EdgeInsets.only(left: 8, top: 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "React Advanced course",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        Text("Batista Oliveira",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Progress",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Rubik-Medium"),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 2),
                                              child: Text(
                                                "10/05/2021",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "Rubik"),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Due time",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Rubik-Medium"),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 2),
                                              child: Text(
                                                "10/05/2021",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "Rubik"),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 13,
                                decoration: BoxDecoration(
                                    color: Color(0xffE9E6E6),
                                    borderRadius: BorderRadius.circular(20)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeTab(int value) {
    setState(() {
      tab = value;
    });
  }
}

class SwitchProgress extends StatefulWidget {
  final Function(int)? changeTab;
  final int? tab;
  const SwitchProgress({Key? key, this.changeTab, this.tab}) : super(key: key);

  @override
  _SwitchProgressState createState() => _SwitchProgressState();
}

class _SwitchProgressState extends State<SwitchProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 220,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            CourseTabItem(
              title: "On progress",
              press: () => widget.changeTab!(1),
              isActive: widget.tab == 1,
            ),
            CourseTabItem(
              title: "Completed",
              press: () => widget.changeTab!(2),
              isActive: widget.tab == 2,
            )
          ],
        ),
      ),
    );
  }
}

class CourseTabItem extends StatelessWidget {
  final String? title;
  final VoidCallback? press;
  final bool? isActive;
  const CourseTabItem({Key? key, this.title, this.press, this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 110,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isActive ?? false ? Color(0xff0079F1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20)),
        child: Text(title ?? "",
            style: TextStyle(
                color: isActive ?? false ? Colors.white : Colors.black,
                fontFamily: isActive ?? false ? 'Rubik-Medium' : "Rubik")),
      ),
    );
  }
}
