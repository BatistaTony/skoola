import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(String)? navigateTo;
  final String? page;
  const CustomNavigationBar({Key? key, this.navigateTo, this.page})
      : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  String page = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      page = widget.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Color(0xff3F3D56),
              borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomNavigationItem(
                  icon: 'home',
                  isActive: page == "home",
                  title: "Courses",
                  press: () => page != "home" ? navigateToPage("home") : null,
                ),
                CustomNavigationItem(
                  icon: 'courses',
                  isActive: page == "myCourses",
                  title: "My courses",
                  press: () =>
                      page != "myCourses" ? navigateToPage("myCourses") : null,
                ),
                CustomNavigationItem(
                  icon: 'profile',
                  isActive: page == "profile",
                  title: "Profile",
                  press: () =>
                      page != "profile" ? navigateToPage("profile") : null,
                ),
                CustomNavigationItem(
                  icon: 'setting',
                  isActive: page == "settings",
                  title: "Settings",
                  press: () =>
                      page != "settings" ? navigateToPage("settings") : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToPage(String pageName) {
    widget.navigateTo!(pageName);
    setState(() {
      page = pageName;
    });
  }
}

class CustomNavigationItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final VoidCallback? press;
  final bool? isActive;
  const CustomNavigationItem(
      {Key? key, this.title, this.icon, this.isActive = false, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/$icon.svg",
                color: isActive ?? false ? Color(0xff0079F1) : Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                title ?? "",
                style: TextStyle(
                    color: isActive ?? false ? Color(0xff0079F1) : Colors.white,
                    fontFamily: isActive ?? false ? 'Rubik-SemiBold' : "Rubik",
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
