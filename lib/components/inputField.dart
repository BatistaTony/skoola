import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function(String)? inputOnchange;
  final String? placeholder;
  final String? Function(String?)? inputValidator;
  final bool? isEnabled;
  const InputField(
      {Key? key,
      this.isEnabled = true,
      this.inputOnchange,
      this.placeholder,
      this.inputValidator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height < 800.0 ? 45 : 53,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 1, style: BorderStyle.solid, color: Color(0xffE5E4E2))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextFormField(
          maxLength: 60,
          textAlignVertical: TextAlignVertical.center,
          onChanged: inputOnchange,
          enabled: isEnabled,
          style:
              TextStyle(color: Colors.white, fontFamily: 'Rubik', fontSize: 16),
          decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: placeholder ?? "",
              hintStyle: TextStyle(color: Color(0xffBEBAB3))),
          validator: inputValidator,
        ),
      ),
    );
  }
}
