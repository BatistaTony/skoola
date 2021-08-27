import 'package:flutter/material.dart';

class OutlinedButtonApp extends StatelessWidget {
  final VoidCallback? press;
  final String? title;
  const OutlinedButtonApp({Key? key, this.title, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        child: Text(
          title ?? "",
          style: TextStyle(
              fontSize: 16,
              color: Color(0xffF8F5F1),
              fontFamily: 'Rubik-SemiBold'),
        ),
      ),
    );
  }
}
