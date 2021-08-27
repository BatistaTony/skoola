import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String? title;
  final VoidCallback? press;
  const ButtonApp({Key? key, this.title, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff0079F1), borderRadius: BorderRadius.circular(6)),
        child: Text(
          title ?? "",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
