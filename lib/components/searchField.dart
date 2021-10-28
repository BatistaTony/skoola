import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatefulWidget {
  final String? placeholder;
  final Function(String)? inputOnchange;

  const SearchField({Key? key, this.placeholder, this.inputOnchange})
      : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String? placeholder;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height < 800.0 ? 45 : 53,
      decoration: BoxDecoration(
          color: Color(0xff222140),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Color(0xffBEBAB3))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextFormField(
          maxLength: 60,
          textAlignVertical: TextAlignVertical.center,
          onChanged: widget.inputOnchange,
          style:
              TextStyle(color: Colors.white, fontFamily: 'Rubik', fontSize: 16),
          decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: placeholder ?? "Search",
              suffixIcon: Container(
                  height: 15,
                  width: 15,
                  padding: EdgeInsets.all(size.height < 800.0 ? 12 : 11),
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: Colors.white,
                    height: 15,
                    width: 15,
                  )),
              hintStyle: TextStyle(color: Color(0xffFBF9F7))),
        ),
      ),
    );
  }
}
