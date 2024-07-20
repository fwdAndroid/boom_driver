import 'package:boom_driver/screens/main/complete.dart';
import 'package:boom_driver/screens/tab/client_offers.dart';
import 'package:boom_driver/screens/tab/completed_ride.dart';
import 'package:boom_driver/screens/tab/progress.dart';
import 'package:boom_driver/screens/tab/send_offers.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  var uuid = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Bookings"),
          bottom: TabBar(
            indicatorColor: mainBtnColor,
            labelColor: mainBtnColor,
            labelStyle: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: tabUnselectedColor,
            unselectedLabelStyle: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            tabs: const <Widget>[
              Tab(
                text: "Offers",
              ),
              Tab(
                text: "Request",
              ),
              Tab(
                text: "Progress",
              ),
              Tab(
                text: "Past Ride",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            ClientOffers(),
            SendOffers(),
            Progress(),
            Complete()
          ],
        ),
      ),
    );
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> _showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
