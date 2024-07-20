import 'package:boom_driver/screens/main/main_dashboard.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/screens/widgets/text_form_field.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:boom_driver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideSetting extends StatefulWidget {
  const RideSetting({super.key});

  @override
  State<RideSetting> createState() => _RideSettingState();
}

class _RideSettingState extends State<RideSetting> {
  bool _switchValue = false; // Initial switch value4
  String mess = "Truned Off"; // Initial message
  TextEditingController providerLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ride Setting",
          style: TextStyle(color: colorWhite),
        ),
        iconTheme: IconThemeData(color: colorWhite),
        backgroundColor: mainBtnColor,
      ),
      body: Column(
        children: [
          Text(
              'Any request sent within mile radius of our location will be automatically accepted.'), // Optional subtitle
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: TextFormInputField(
                controller: providerLocation,
                hintText: "Enter Radius",
                IconSuffix: Icons.radar,
                textInputType: TextInputType.number),
          ),

          SaveButton(
              title: "Set",
              onTap: () {
                showMessageBar("Radius is Set", context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => MainDashboard()));
              })
        ],
      ),
    );
  }

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
