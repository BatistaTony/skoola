import 'package:flutter/material.dart';
import 'package:skoola/components/courseCard.dart';
import 'package:skoola/components/customAppBar.dart';
import 'package:skoola/components/customNavigationBar.dart';
import 'package:skoola/components/searchField.dart';
import 'package:skoola/models/course-data.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void seePreview(CourseType course) {
      Navigator.pushNamed(context, "coursePreview");
    }

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(),
          toolbarHeight: 190,
          flexibleSpace: CustomAppBar(
            title: "Batista Oliveira",
            subtitle: "Hello !",
            extrawidget: Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SearchField(),
                  ],
                )),
          )),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
          alignment: Alignment.topCenter,
          child: ListView(
              children: courses
                  .map((course) => new CourseCard(
                        cover: course.cover,
                        price: course.price,
                        title: course.title,
                        description: course.description,
                        tags: course.tags,
                        press: () => seePreview(course),
                      ))
                  .toList()),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        navigateTo: (page) => print(page),
        initialPage: "home",
      ),
    );
  }
}

List<CourseType> courses = [
  CourseType(
      cover: "cover.png",
      price: 12.0000,
      title: "UX Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga"),
  CourseType(
      cover: "cover.png",
      price: 12,
      title: "UX Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga"),
  CourseType(
      cover: "cover.png",
      price: 12,
      title: "Reactjs Basics",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#reacr, #redux, #skoola"),
  CourseType(
      cover: "cover.png",
      price: 12,
      title: "UI Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga"),
  CourseType(
      cover: "cover.png",
      price: 12,
      title: "Java Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga")
];
