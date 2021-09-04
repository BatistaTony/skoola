import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Settings").build(context),
      body: Center(
        child: Text("settings"),
      ),
    );
  }
}
