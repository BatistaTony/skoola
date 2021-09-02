import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordField extends StatefulWidget {
  final Function(String) inputOnChange;
  final bool? isShowPassword;
  const PasswordField(
      {Key? key, required this.inputOnChange, this.isShowPassword = false})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool? isShowPassword = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isShowPassword = widget.isShowPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height < 800.0 ? 45 : 53,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Color(0xffBEBAB3))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChange,
          style:
              TextStyle(color: Colors.white, fontFamily: 'Rubik', fontSize: 16),
          obscureText: !isShowPassword!,
          enableSuggestions: false,
          maxLength: 10,
          autocorrect: false,
          decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: showPassword,
                child: Container(
                  margin: EdgeInsets.only(right: size.height < 800.0 ? 16 : 15),
                  width: 10,
                  height: 10,
                  child: SvgPicture.asset(
                    !isShowPassword!
                        ? "assets/icons/see.svg"
                        : "assets/icons/notsee.svg",
                    color: Colors.white,
                  ),
                ),
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: Color(0xffBEBAB3))),
        ),
      ),
    );
  }

  void onChange(String value) {
    widget.inputOnChange(value);
  }

  void showPassword() {
    setState(() {
      isShowPassword = !isShowPassword!;
    });
  }
}
