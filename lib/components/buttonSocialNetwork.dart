import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonSocialNetwork extends StatelessWidget {
  final VoidCallback? press;
  final String? icon;
  const ButtonSocialNetwork({Key? key, this.press, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          width: 40,
          height: 40,
          child: SvgPicture.asset("assets/icons/$icon.svg"),
        ));
  }
}
