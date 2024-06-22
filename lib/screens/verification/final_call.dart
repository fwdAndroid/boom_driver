import 'package:boom_driver/screens/main/main_dashboard.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/material.dart';

class FinalCall extends StatefulWidget {
  const FinalCall({super.key});

  @override
  State<FinalCall> createState() => _FinalCallState();
}

class _FinalCallState extends State<FinalCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/call.png",
              height: 160,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "You got a Call.",
              style: TextStyle(
                  color: colorBlack, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Stay on for support team verification. After completion, you'll be redirected to your Driver Dashboard for seamless navigation and updates. Thank you for your cooperation!.",
                style: TextStyle(
                    color: colorBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: SaveButton(
                  title: "Done",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MainDashboard()));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
