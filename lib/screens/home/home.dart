import 'package:flutter/material.dart';
import 'package:skoola/components/courseCard.dart';
import 'package:skoola/components/customAppBar.dart';
import 'package:skoola/components/searchField.dart';
import 'package:skoola/models/course.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 10),
          child: ListView(
              children: courses
                  .map((course) => new CourseCard(
                        cover: course.cover,
                        price: course.price,
                        title: course.title,
                        description: course.description,
                        tags: course.tags,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}

List<Course> courses = [
  Course(
      cover: "cover.png",
      price: 12,
      title: "UX Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga"),
  Course(
      cover: "cover.png",
      price: 12,
      title: "UX Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga"),
  Course(
      cover: "cover.png",
      price: 12,
      title: "Reactjs Basics",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#reacr, #redux, #skoola"),
  Course(
      cover: "cover.png",
      price: 12,
      title: "UI Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga"),
  Course(
      cover: "cover.png",
      price: 12,
      title: "Java Design",
      description:
          "You can launch a new career in web develop-ment today by learning HTML & CSS",
      tags: "#ux, #skoola, #benga")
];
