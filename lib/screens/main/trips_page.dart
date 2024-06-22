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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Bookings"),
          bottom: TabBar(
            indicatorColor: mainBtnColor,
            labelColor: mainBtnColor,
            labelStyle: GoogleFonts.manrope(
              fontSize: 14,
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
                text: "Send Offer",
              ),
              Tab(
                text: "In Progress",
              ),
              Tab(
                text: "Completed Rides",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MyOffers(),
            DriverOffers(),
            Progress(),
            CompletedRide()
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
