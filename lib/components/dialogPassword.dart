import 'package:flutter/material.dart';
import 'package:skoola/components/customButton.dart';

class ModalPasswordFeeddback extends StatelessWidget {
  const ModalPasswordFeeddback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xff292639),
              borderRadius: BorderRadius.circular(30)),
          height: size.height * 0.30,
          width: size.width * 0.90,
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("lorem"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      width: size.width * 0.40,
                      child: ButtonApp(
                        title: "ok",
                        press: () => Navigator.pop(context, false),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ModalButtonGroup extends StatelessWidget {
  final bool? isLoading;
  final VoidCallback? update;
  final VoidCallback? cancel;
  const ModalButtonGroup({Key? key, this.cancel, this.isLoading, this.update})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.40,
          child: ButtonApp(
            title: "cancel",
            bgColor: Color(0xffDB3C3C),
            press: isLoading ?? true ? null : cancel,
            isDisabled: isLoading,
          ),
        ),
        Container(
          width: size.width * 0.40,
          child: ButtonApp(
            title: "Update",
            press: isLoading ?? true ? null : update,
            isDisabled: isLoading,
          ),
        ),
      ],
    );
  }
}
