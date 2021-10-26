import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimpleAppBar extends StatelessWidget {
  final String? title;
  final VoidCallback? goBackFunc;
  final bool canBack;
  const SimpleAppBar(
      {Key? key, this.title, this.goBackFunc, this.canBack = true})
      : super(key: key);

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
          onTap: canBack ? goBack : null,
          child: canBack
              ? Container(
                  width: 15,
                  height: 15,
                  padding: EdgeInsets.all(19),
                  child: SvgPicture.asset(
                    "assets/icons/back.svg",
                  ),
                )
              : null,
        ),
        centerTitle: true,
        title: Text(title ?? "",
            style:
                TextStyle(color: Colors.white, fontFamily: 'Rubki-SemiBold')));
  }
}
