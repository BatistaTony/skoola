import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseTests extends StatelessWidget {
  const CourseTests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ListView(
        children: <Widget>[
          CourseTestListItem(
            cover: "assets/images/cover.png",
            id: "3254dg45",
            description:
                "Simple test about react components, children and stuffs related, and with some memes too, lol",
            isDone: true,
            subTitle: "Quiz 1",
            title: "React Components",
          ),
          CourseTestListItem(
            cover: "assets/images/cover.png",
            id: "3254dg45",
            description:
                "Simple test about react components, children and stuffs related, and with some memes too, lol",
            isDone: false,
            subTitle: "Quiz 2",
            title: "React Props",
          ),
          CourseTestListItem(
            cover: "assets/images/cover.png",
            id: "3254dg45",
            description:
                "Simple test about react components, children and stuffs related, and with some memes too, lol",
            isDone: true,
            subTitle: "Quiz 3",
            title: "React State",
          )
        ],
      ),
    );
  }
}

class CourseTestListItem extends StatelessWidget {
  final String? id;
  final String? cover;
  final String? title;
  final String? subTitle;
  final String? description;
  final bool? isDone;

  const CourseTestListItem(
      {Key? key,
      this.cover,
      this.title,
      this.subTitle,
      this.description,
      this.isDone = false,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 265,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color(0xff3F3D56), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        cover!,
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 80,
                  width: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subTitle!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Rubik-Medium',
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              child: Text(isDone! ? "🏆" : "",
                                  style: TextStyle(
                                    fontSize: 25,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Text(
                        title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik-Medium',
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            child: Text(
              description!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 17,
              ),
            ),
          ),
          CourseTestButton(
            press: () => makeTest(context),
          )
        ],
      ),
    );
  }

  void makeTest(context) {
    Navigator.pushNamed(context, "courseTest");
  }
}

class CourseTestButton extends StatelessWidget {
  final VoidCallback? press;
  const CourseTestButton({Key? key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Color(0xff0079F1), borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 34,
              height: 34,
            ),
            Text(
              "Begin",
              style: TextStyle(
                  fontSize: 20, fontFamily: "Rubik", color: Colors.white),
            ),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: Color(0xff3F3D56),
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                  padding: EdgeInsets.all(7),
                  child: SvgPicture.asset(
                    "assets/icons/arrow-right.svg",
                    width: 20,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
