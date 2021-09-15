import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';

class SavedCourses extends StatelessWidget {
  const SavedCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "SavedCourses").build(context),
      body: Center(
        child: Text("SavedCourses"),
      ),
    );
  }
}
