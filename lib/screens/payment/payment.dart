import 'package:flutter/material.dart';
import 'package:skoola/components/simpleAppBar.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Payment").build(context),
      body: Center(
        child: Text("Payment"),
      ),
    );
  }
}
