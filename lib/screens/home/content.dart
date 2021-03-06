import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:skoola/components/courseCard.dart';
import 'package:skoola/components/customAppBar.dart';
import 'package:skoola/components/searchField.dart';
import 'package:skoola/store/app_state.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({Key? key}) : super(key: key);

  @override
  _ContentHomeState createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                            placeholder:
                                "search here tags or title of the course"),
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
                  return Container(
                    height: size.height * 0.80,
                    width: size.width,
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                } else {
                  var myCourses = snapshot.data!.docs;

                  var coursesFiltered = search != ""
                      ? myCourses.where((dynamic element) {
                          return element
                                  .data()!["title"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(search) ||
                              element
                                  .data()!["tags"]
                                  .toString()
                                  .toLowerCase()
                                  .contains(search);
                        })
                      : myCourses;

                  if (coursesFiltered.isEmpty) {
                    return Container(
                      height: size.height * 0.80,
                      width: size.width,
                      child: Center(
                        child: Text(
                          "Course was not found !",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Rubik-Medium'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return ListView(
                      children: coursesFiltered
                          .map<Widget>((DocumentSnapshot document) {
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
    print(course);
    // Navigator.pushNamed(context, "coursePreview");
  }

  void inputOnchange(String value) {
    setState(() {
      search = value;
    });
  }
}
