import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String? cover;
  final String? title;
  final String? tags;
  final String? description;
  final Object? price;
  final VoidCallback? press;
  const CourseCard(
      {Key? key,
      this.cover,
      this.description,
      this.price,
      this.tags,
      this.title,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 290,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    height: 189,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14)),
                        child: Image.asset(
                          "assets/images/${cover ?? "logo.png"}",
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                  bottom: 10.5,
                  right: 10.5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff0079F1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Text(
                        "\$${price ?? 0}",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik-Medium',
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 9, left: 12, right: 12, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title ?? "",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Rubik-Medium',
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tags ?? "",
                        style: TextStyle(
                            color: Color(0xff0079F1),
                            fontFamily: 'Rubik-Medium',
                            fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          description ?? "",
                          style: TextStyle(
                              color: Color(0xff454545),
                              fontFamily: 'Rubki-Medium',
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
