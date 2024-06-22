import 'package:boom_driver/screens/trip/confrim_trip.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Client Name",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorBlack),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Fawad Kaleem",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12,
                                      color: colorBlack),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Call",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorBlack),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "+912485352664",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12,
                                      color: colorBlack),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Distance",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorBlack),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "15 KM",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12,
                                      color: colorBlack),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Duration",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorBlack),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "43 Min 2 Sec",
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12,
                                      color: colorBlack),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SaveButton(
                          title: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SaveButton(
                          title: "Confrim",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ConfrimTrip()));
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SaveButton(
                          title: "Send Alternative Price", onTap: () {}),
                    )
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
