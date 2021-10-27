import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:skoola/components/courseCard.dart';
import 'package:skoola/components/customAppBar.dart';
import 'package:skoola/components/searchField.dart';
import 'package:skoola/models/course-data.dart';
import 'package:skoola/store/app_state.dart';

class ContentHome extends StatelessWidget {
  const ContentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Container(),
              toolbarHeight: 190,
              flexibleSpace: CustomAppBar(
                title: state.user!.name,
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
          body: Center(child: HomeCourseContent()),
          // bottomNavigationBar: CustomNavigationBar(
          //   navigateTo: (page) => print(page),
          //   initialPage: "home",
          // ),
        );
      },
    );
  }
}

class HomeCourseContent extends StatefulWidget {
  const HomeCourseContent({Key? key}) : super(key: key);

  @override
  _HomeCourseContentState createState() => _HomeCourseContentState();
}

class _HomeCourseContentState extends State<HomeCourseContent> {
  List<CourseType> listCourses = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
      alignment: Alignment.topCenter,
      child: FutureBuilder(
        future: getCourses(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> myCourses =
                snapshot.data
                    as List<QueryDocumentSnapshot<Map<String, dynamic>>>;
            return ListView(
                children: myCourses.map<Widget>((course) {
              List<String>? tags = course.data()["tags"] as List<String>;
              print("inside the widget ==> $tags");

              var shortDescription =
                  "${course.data()["description"].toString().substring(0, 90)}...";

              return new CourseCard(
                cover: course.data()["cover"],
                price: course.data()["price"],
                title: course.data()["name"],
                description: shortDescription,
                tags: ["tags"],
                press: () => seePreview(course.data()),
              );
            }).toList());
          }
        },
      ),
    );
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCourses() async {
    FirebaseFirestore firebaseDb = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> coursesCollection =
        await firebaseDb.collection("courses").get();
    print(coursesCollection.docs[0]["id"]);
    return coursesCollection.docs.toList();
  }

  void seePreview(dynamic course) {
    Navigator.pushNamed(context, "coursePreview");
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
