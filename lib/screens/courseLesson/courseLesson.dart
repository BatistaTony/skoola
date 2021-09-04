import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';

class CourseLesson extends StatelessWidget {
  const CourseLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "CourseLesson").build(context),
      body: Center(
        child: Text("CourseLesson"),
      ),
    );
  }
}
