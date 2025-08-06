import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PagePinPutView extends StatelessWidget {
  const PagePinPutView({
    super.key,
    required this.pinPutController,
    required this.pinPutFocusNode,
    required this.onCompleted,
    required this.length,
  });

  final TextEditingController pinPutController;
  final FocusNode pinPutFocusNode;
  final ValueChanged<String> onCompleted;
  final int length;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      child: Pinput(
        defaultPinTheme: defaultPinTheme,
        showCursor: true,
        length: length,
        onCompleted: onCompleted,
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        submittedPinTheme: defaultPinTheme,
        followingPinTheme: defaultPinTheme,
      ),
    );
  }
}
