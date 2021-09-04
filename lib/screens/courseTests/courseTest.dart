import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';

class CourseTest extends StatelessWidget {
  const CourseTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "course Tests").build(context),
      body: Center(
        child: Text("course Tests"),
      ),
    );
  }
}
