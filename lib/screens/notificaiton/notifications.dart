import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(color: colorWhite),
        ),
        iconTheme: IconThemeData(color: colorWhite),
        backgroundColor: mainBtnColor,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text("Ride is Bookied"),
              trailing: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffF4721E)),
                child: Text(
                  "2",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: colorWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Divider(
                color: dividerColor.withOpacity(.4),
              ),
            )
          ],
        );
      }),
    );
  }
}
