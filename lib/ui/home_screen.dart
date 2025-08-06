import 'package:flutter/material.dart';
import 'package:otp_example/ui/sms_verifaction_screen.dart';
import 'package:otp_example/widget/cutom_text_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text("Login"),
                  Text("Enter number"),
                  CutomTextInput(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),
              onPressed: controller.text.length != 15
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SmsVerifactionScreen(number: controller.text),
                        ),
                      );
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Send otp", style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
