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
                        SearchField(
                          inputOnchange: inputOnchange,
                        ),
                      ],
                    )),
              )),
          body: Center(
              child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
            alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: getCourses(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  var myCourses = snapshot.data!.docs;
                  return ListView(
                      children:
                          myCourses.map<Widget>((DocumentSnapshot document) {
                    Map<String, dynamic> course =
                        document.data()! as Map<String, dynamic>;
                    List<String>? tags = List.castFrom(course["tags"]);

                    return new CourseCard(
                      cover: course["cover"],
                      price: course["price"],
                      title: course["title"],
                      description: course["description"],
                      tags: tags,
                      press: () => seePreview(course, context),
                    );
                  }).toList());
                }
              },
            ),
          )),
        );
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCourses() {
    FirebaseFirestore firebaseDb = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> coursesCollection =
        firebaseDb.collection("courses").snapshots();

    return coursesCollection;
  }

  void seePreview(dynamic course, context) {
    Navigator.pushNamed(context, "coursePreview");
  }

  void inputOnchange(String value) {
    print(value);
  }
}
