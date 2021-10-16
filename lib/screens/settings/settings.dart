import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redux/redux.dart';
import 'package:skoola/components/customButton.dart';
import 'package:skoola/components/simpleAppBar.dart';
import 'package:skoola/components/switch.dart';
import 'package:skoola/screens/login/login.dart';
import 'package:skoola/screens/settings/modalEmail.dart';
import 'package:skoola/screens/settings/modalName.dart';
import 'package:skoola/store/actions/user.dart';
import 'package:skoola/store/app_state.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Settings",
        isCanForward: false,
      ).build(context),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SettingMenu(),
            ButtonLogOut(
              press: () => logout(context),
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

class SettingMenu extends StatelessWidget {
  const SettingMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);
    var userState = store.state.user;

    return Column(
      children: [
        NotificationContainer(),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(bottom: 15, top: 20),
          child: Text("Account Information",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Rubik-Medium",
                  fontSize: 19)),
        ),
        SettingMenuItem(
          icon: "courses",
          press: () => showModalBottomSheet(
              isDismissible: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return NameSetting();
              }),
          title: "Name",
          subTitle: userState!.name,
        ),
        SettingMenuItem(
          icon: "courses",
          press: () => showModalBottomSheet(
              isDismissible: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return EmailSetting();
              }),
          title: "Email",
          subTitle: userState.email,
        ),
        SettingMenuItem(
          icon: "courses",
          press: () => {},
          title: "Password",
          subTitle: "****************",
        ),
      ],
    );
  }
}

class SettingMenuItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final String? subTitle;
  final VoidCallback? press;
  const SettingMenuItem(
      {Key? key, this.title, this.subTitle, this.icon, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffCCCCCC), width: 1),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffCCCCCC)),
                        borderRadius: BorderRadius.circular(100)),
                    child: SvgPicture.asset(
                      "assets/icons/$icon.svg",
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Text(title ?? "",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik-Medium",
                                fontSize: 19)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Text(subTitle ?? "",
                            style: TextStyle(
                                color: Color(0xff78746D),
                                fontFamily: "Rubik",
                                fontSize: 13)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: SvgPicture.asset(
                "assets/icons/next.svg",
                color: Colors.white,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final VoidCallback? press;
  const NotificationContainer({Key? key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffCCCCCC), width: 1),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffCCCCCC)),
                        borderRadius: BorderRadius.circular(100)),
                    child: SvgPicture.asset(
                      "assets/icons/courses.svg",
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    child: Text("Notifications",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Rubik-Medium",
                            fontSize: 19)),
                  )
                ],
              ),
            ),
            SwitchControl(
              onChange: (status) => print(status),
              status: false,
            )
          ],
        ),
      ),
    );
  }
}

class ButtonLogOut extends StatelessWidget {
  final VoidCallback? press;
  const ButtonLogOut({Key? key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        height: size.height < 800.0 ? 50 : 56,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Color(0xffDB3C3C), borderRadius: BorderRadius.circular(30)),
        child: Text(
          "Log out",
          style: TextStyle(
              fontSize: 18,
              fontFamily: "Rubik-Medium",
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
