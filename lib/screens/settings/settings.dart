import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:skoola/components/simpleAppBar.dart';
import 'package:skoola/screens/login/login.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Settings").build(context),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text("settings"),
            ),
            GestureDetector(
              onTap: () => logout(context),
              child: Text("Log out"),
            )
          ],
        ),
      ),
    );
  }

  void logout(context) async {
    Store<AppState> store = StoreProvider.of<AppState>(context);

    firebaseAuth.signOut().then((value) {
      store.dispatch(LogOut());
      goToHome(context);
    });
  }

  void goToHome(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      ),
      (route) => false,
    );
  }
}
