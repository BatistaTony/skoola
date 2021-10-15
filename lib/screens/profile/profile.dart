import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skoola/components/customNavigationBar.dart';
import 'package:skoola/components/simpleAppBar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: SimpleAppBar(
        title: "Profile",
        isCanForward: false,
      ).build(context),
      body: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 122,
                      height: 122,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/avatar.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child: Text(
                        "Batista Oliveira",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Rubik-Medium",
                            fontSize: 26),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1.5),
                      child: Text("batistatomeoliveira96@gmail.com",
                          style: TextStyle(
                              color: Color(0xff8A8A90),
                              fontFamily: "Rubik",
                              fontSize: 15)),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      ProfileItem(
                          title: "Courses",
                          icon: "courses",
                          press: () => goTo(context, 1)),
                      ProfileItem(
                          title: "Saved",
                          icon: "courses",
                          press: () => goTo(context, 2)),
                      ProfileItem(
                          title: "Payment",
                          icon: "courses",
                          press: () => goTo(context, 3))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomNavigationBar(
      //   navigateTo: (page) => print(page),
      //   initialPage: "profile",
      // ),
    );
  }

  void goTo(BuildContext context, int route) {
    switch (route) {
      case 1:
        {
          Navigator.pushNamed(context, "myCourses");
          break;
        }

      case 2:
        {
          Navigator.pushNamed(context, "savedCourses");
          break;
        }

      case 3:
        {
          Navigator.pushNamed(context, "payment");
          break;
        }
    }
  }

  void backHome(BuildContext context) {
    Navigator.pushNamed(context, "home");
  }
}

class ProfileItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final VoidCallback? press;
  const ProfileItem({Key? key, this.title, this.icon, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffCCCCCC)),
                        borderRadius: BorderRadius.circular(100)),
                    child: SvgPicture.asset(
                      "assets/icons/$icon.svg",
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    child: Text(title ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Rubik-Medium",
                            fontSize: 20)),
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
