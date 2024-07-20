import 'package:boom_driver/screens/main/main_dashboard.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/screens/widgets/text_form_field.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:boom_driver/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteRide extends StatefulWidget {
  final uuid;
  final clientUid;
  final driverName;
  final driverEmail;
  final driverId;
  final status;
  final price;
  final destination;
  final cureentlocation;
  final name;
  final time;
  final date;
  final photo;
  final email;
  final counterPrice;
  final driverPhoto;
  CompleteRide(
      {super.key,
      required this.clientUid,
      required this.cureentlocation,
      required this.destination,
      required this.name,
      required this.counterPrice,
      required this.time,
      required this.driverPhoto,
      required this.date,
      required this.photo,
      required this.email,
      required this.driverEmail,
      required this.driverId,
      required this.driverName,
      required this.price,
      required this.status,
      required this.uuid});

  @override
  State<CompleteRide> createState() => _CompleteRideState();
}

class _CompleteRideState extends State<CompleteRide> {
  TextEditingController _controller = TextEditingController();
  bool _isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/aa.png",
                fit: BoxFit.cover,
                height: 150,
                width: MediaQuery.of(context).size.width),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    widget.name,
                    style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorBlack),
                  ),
                  subtitle: Text(
                    widget.email,
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: colorBlack),
                  ),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.photo,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "PickUp Point:",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.cureentlocation,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Destination:",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.destination,
                style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Date and Time:",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorBlack),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.date,
                    style: GoogleFonts.nunitoSans(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.time,
                    style: GoogleFonts.nunitoSans(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Offer Price",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorBlack),
                      ),
                      Text(
                        widget.price + "\$",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorBlack),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _isLoad
                ? Center(
                    child: CircularProgressIndicator(
                      color: mainBtnColor,
                    ),
                  )
                : Center(
                    child: SaveButton(
                        title: "Completed",
                        onTap: () async {
                          setState(() {
                            _isLoad = true;
                          });
                          int finalPrice = _controller.text.isNotEmpty
                              ? int.parse(_controller.text)
                              : int.parse(widget.price);

                          await FirebaseFirestore.instance
                              .collection("booking")
                              .doc(widget.uuid)
                              .update({
                            "status": "received",
                            "driverEmail": widget.driverEmail,
                            "driverId": widget.driverId,
                            "driverPhoto": widget.driverPhoto,
                            "driverName": widget.driverName,
                            "price": finalPrice,
                          });
                          setState(() {
                            _isLoad = false;
                          });
                          showMessageBar("Offer Send Successfully", context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => MainDashboard()));
                        }))
          ],
        ),
      ),
    );
  }
}
