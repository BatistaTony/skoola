import 'package:flutter/material.dart';
import 'package:skoola/components/customNavigationBar.dart';
import 'package:skoola/components/simpleAppBar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Profile").build(context),
      body: Container(child: Text("Profile coming today soon ")),
      bottomNavigationBar: CustomNavigationBar(
        navigateTo: (page) => print(page),
        initialPage: "profile",
      ),
    );
  }

  void backHome(BuildContext context) {
    Navigator.pushNamed(context, "home");
  }
}
