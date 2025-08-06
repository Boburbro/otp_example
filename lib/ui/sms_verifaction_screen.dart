import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_example/widget/page_pin_put_view.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SmsVerifactionScreen extends StatefulWidget {
  const SmsVerifactionScreen({super.key, required this.number});
  final String number;

  @override
  State<SmsVerifactionScreen> createState() => _SmsVerifactionScreenState();
}

class _SmsVerifactionScreenState extends State<SmsVerifactionScreen> {
  final smsController = TextEditingController();
  final focusNode = FocusNode();
  bool readyToSubmit = false;

  final SmsAutoFill smsAutoFill = SmsAutoFill();
  late Timer _timer;
  int mySeconds = 59;

  void listenForTheCode() async {
    await SmsAutoFill().listenForCode().then((value) {
      smsAutoFill.code.listen((code) {
        if (code.length == 6) {
          smsController.text = code;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(content: Text("code: $code")),
          );
          if (!mounted) return;
        }
      });
    });
  }

  Future<void> unregisterListener() {
    return smsAutoFill.unregisterListener();
  }

  @override
  void initState() {
    listenForTheCode();
    super.initState();
    smsController.addListener(() {
      if (smsController.text.length < 6) {
        setState(() {
          readyToSubmit = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    unregisterListener();
    smsController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("sended sms to ${widget.number}"),
            SizedBox(height: 20),
            PagePinPutView(
              pinPutController: smsController,
              pinPutFocusNode: focusNode,
              onCompleted: (otp) {
                print(otp);
              },
              length: 6,
            ),
          ],
        ),
      ),
    );
  }
}
