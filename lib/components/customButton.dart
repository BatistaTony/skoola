import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String? title;
  final VoidCallback? press;
  const ButtonApp({Key? key, this.title, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        height: size.height < 800.0 ? 50 : 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff0079F1), borderRadius: BorderRadius.circular(6)),
        child: Text(
          title ?? "",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
