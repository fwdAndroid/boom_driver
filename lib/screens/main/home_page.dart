import 'package:boom_driver/screens/main/trips_page.dart';
import 'package:boom_driver/screens/tab/progress.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../help/support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          "assets/main.png",
          height: 200,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => Trips()));
              },
              leading: Icon(
                Icons.trip_origin,
              ),
              title: Text(
                "All Trip",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: Text(
                "All current trips details are shown here",
                style: TextStyle(fontSize: 10, color: colorBlack),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Progress()));
              },
              leading: Icon(
                Icons.trip_origin,
              ),
              title: Text(
                "New Trip",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: Text(
                "All current trips details are shown here",
                style: TextStyle(fontSize: 10, color: colorBlack),
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Support()));
            },
            leading: Icon(
              Icons.help,
            ),
            title: Text(
              "Support",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Text(
              "All current trips details are shown here",
              style: TextStyle(fontSize: 10, color: colorBlack),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Support()));
              },
              leading: Icon(
                Icons.help,
              ),
              title: Text(
                "Earning",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: Text(
                "All current trips details are shown here",
                style: TextStyle(fontSize: 10, color: colorBlack),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
