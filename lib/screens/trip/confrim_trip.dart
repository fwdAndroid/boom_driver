import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfrimTrip extends StatefulWidget {
  const ConfrimTrip({super.key});

  @override
  State<ConfrimTrip> createState() => _ConfrimTripState();
}

class _ConfrimTripState extends State<ConfrimTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainBtnColor,
          onPressed: () {},
          child: Icon(
            Icons.call,
            color: colorWhite,
          ),
        ),
        backgroundColor: Colors.grey,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/pic.png"),
                      ),
                      title: Text(
                        "Darlene Steward",
                        style: GoogleFonts.inter(
                            color: mainBtnColor, fontSize: 15),
                      ),
                      subtitle: Text(
                        "4.9 based on 100 ratings",
                        style: GoogleFonts.inter(
                            color: secondaryTextColor, fontSize: 12),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Ride Time",
                        style: GoogleFonts.inter(
                            color: mainBtnColor, fontSize: 15),
                      ),
                      subtitle: Text(
                        "15 Mins",
                        style: GoogleFonts.inter(
                            color: secondaryTextColor, fontSize: 12),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Address",
                        style: GoogleFonts.inter(
                            color: mainBtnColor, fontSize: 15),
                      ),
                      subtitle: Text(
                        "Wisteria st 30, Houston, TX",
                        style:
                            GoogleFonts.inter(color: colorBlack, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/map.png",
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover)),
        ));
  }
}
