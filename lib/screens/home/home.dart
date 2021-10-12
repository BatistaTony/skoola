import 'package:flutter/material.dart';
import 'package:skoola/components/customNavigationBar.dart';
import 'package:skoola/screens/home/content.dart';
import 'package:skoola/screens/myCourses/myCourses.dart';
import 'package:skoola/screens/profile/profile.dart';
import 'package:skoola/screens/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController(initialPage: 0);
  var selectedPage;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    var pages = ["home", "profile", "myCourses", "settings"];
    List<Widget> components = [
      ContentHome(),
      Profile(),
      MyCourses(),
      Settings()
    ];

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: components,
      ),
      bottomNavigationBar: CustomNavigationBar(
        navigateTo: (page) => changePageWithAnimation(pages.indexOf(page)),
        page: pages[selectedPage],
      ),
    );
  }

  void changePageWithAnimation(int pageNumber) {
    setState(() {
      selectedPage = pageNumber;
    });
    pageController.animateTo(1,
        duration: Duration(seconds: 1), curve: Curves.linear);
    pageController.jumpToPage(pageNumber);
  }
}
