import 'package:flutter/material.dart';

class SwitchControl extends StatefulWidget {
  final Function(bool)? onChange;
  final bool? status;
  const SwitchControl({Key? key, this.onChange, this.status}) : super(key: key);

  @override
  _SwitchControlState createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl> {
  bool status = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      status = widget.status!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorBg = status ? Color(0xff0079F1) : Color(0xff3F3D56);
    var _duration = 1;
    return GestureDetector(
      onTap: setStatus,
      child: AnimatedContainer(
        duration: Duration(seconds: _duration.toInt()),
        width: 40,
        height: 20,
        decoration: BoxDecoration(
            color: colorBg, borderRadius: BorderRadius.circular(35)),
        child: Container(
          child: Row(
            mainAxisAlignment:
                status ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(seconds: 1),
                  margin: EdgeInsets.only(right: 5, left: 5),
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Color(0xffDB3C3C),
                      borderRadius: BorderRadius.circular(30))),
            ],
          ),
        ),
      ),
    );
  }

  void setStatus() {
    setState(() {
      status = !status;
    });

    widget.onChange!(status);
  }
}
