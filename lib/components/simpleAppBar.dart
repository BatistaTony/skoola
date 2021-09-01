import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimpleAppBar extends StatelessWidget {
  final String? title;
  final VoidCallback? goBackFunc;
  const SimpleAppBar({Key? key, this.title, this.goBackFunc}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    void goBack() {
      if (goBackFunc == null) {
        Navigator.pop(context);
      } else {
        goBackFunc!();
      }
    }

    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: goBack,
          child: Container(
            width: 15,
            height: 15,
            padding: EdgeInsets.all(19),
            child: SvgPicture.asset(
              "assets/icons/back.svg",
            ),
          ),
        ),
        title: Text(title ?? "",
            style:
                TextStyle(color: Colors.white, fontFamily: 'Rubki-SemiBold')));
  }
}
