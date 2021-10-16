import 'package:flutter/material.dart';
import 'package:skoola/components/customButton.dart';

class ModalSetting extends StatelessWidget {
  final VoidCallback? onUpdate;
  final bool? isLoading;
  final double? height;
  final List<Widget>? children;
  const ModalSetting(
      {Key? key, this.onUpdate, this.isLoading, this.children, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(children: [
      Positioned(
        left: 0,
        bottom: -10,
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Color(0xff292639),
              borderRadius: BorderRadius.circular(30)),
          width: size.width,
          height: height != null ? size.height * height! : size.height * 0.40,
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: children ?? [],
                ),
                ModalButtonGroup(
                    cancel: () => Navigator.pop(context, false),
                    update: onUpdate,
                    isLoading: isLoading),
              ],
            ),
          ),
        ),
      ),
    ]);
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
