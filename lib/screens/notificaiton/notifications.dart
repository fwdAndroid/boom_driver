import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _switchValue = false; // Initial switch value
  String mess = "Truned Off"; // Initial message

  @override
  Widget build(BuildContext context) {
    bool _switchValue = false; // Initial switch value

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
      body: Column(children: [
        Center(
          child: SwitchListTile(
            title: Text(
              'Private Profile',
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17),
            ), // The title of the ListTile
            subtitle: Text(
                'Make your profile private so only registered clients can see your profile and booked you'), // Optional subtitle
            value: _switchValue, // The current value of the switch
            onChanged: (newValue) {
              // Callback when the switch is toggled
              setState(() {
                _switchValue = newValue;
                changeMessage(); // Call the function to update the message
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: colorBlack,
          ),
        ),
        Center(
          child: SwitchListTile(
            title: Text(
              'Notification Alerts',
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17),
            ), // The title of the ListTile
            subtitle: Text(
                'Recived alerts about daily announcements updates and promo codes'), // Optional subtitle
            value: _switchValue, // The current value of the switch
            onChanged: (newValue) {
              // Callback when the switch is toggled
              setState(() {
                _switchValue = newValue;
                changeMessage(); // Call the function to update the message
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: colorBlack,
          ),
        ),
        Center(
          child: SwitchListTile(
            title: Text(
              ' Private Notifications',
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 17),
            ), // The title of the ListTile
            subtitle: Text(
                'Turn on and off Private Notification '), // Optional subtitle
            value: _switchValue, // The current value of the switch
            onChanged: (newValue) {
              // Callback when the switch is toggled
              setState(() {
                _switchValue = newValue;
                changeMessage(); // Call the function to update the message
              });
            },
          ),
        ),
      ]),
    );
  }

  // Function to change the message based on the switch value
  void changeMessage() {
    setState(() {
      if (_switchValue) {
        mess = "Truned On";
      } else {
        mess = "Truned Off";
      }
    });
  }
}
