import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? extrawidget;
  const CustomAppBar({Key? key, this.title, this.subtitle, this.extrawidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff0079F1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 55),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Regular",
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        title ?? "",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik-SemiBold',
                            fontSize: 32),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  child: SvgPicture.asset("assets/icons/notification.svg",
                      color: Colors.white),
                ),
              ],
            ),
            extrawidget ?? Container()
          ],
        ),
      ),
    );
  }
}
