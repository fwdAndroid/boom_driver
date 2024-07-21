import 'package:boom_driver/cars/edit_car_profile.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/screens/widgets/text_form_field.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({
    super.key,
  }); // Update the constructor

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  TextEditingController customerFullNameContoller = TextEditingController();
  TextEditingController customerPhoneNumberController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController email = TextEditingController();
  String? imageUrl;
  late Map<String, dynamic> data; // Add this line

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      // Fetch data from Firestore using the unique ID
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('cars')
          .doc(data['uuid']) // Use the passed unique ID
          .get();

      data = doc.data() as Map<String, dynamic>;

      // Update the controllers with the fetched data
      setState(() {
        customerFullNameContoller.text = data['carName'];
        customerPhoneNumberController.text = data['plate'];
        customerAddressController.text = data['registerNumber'].toString();
        imageUrl = data['carPhoto'];
        email.text = data['seats'];
      });
    } catch (e) {
      // Handle any errors
      print('Error fetching car info: $e');
      // Optionally, you can show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching car info. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            "Car Info",
            style: GoogleFonts.workSans(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: mainBtnColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (imageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      child: CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage(imageUrl!))),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                    controller: customerFullNameContoller,
                    hintText: "Full Name",
                    IconSuffix: Icons.person,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: email,
                    hintText: "Email",
                    IconSuffix: Icons.email,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: customerPhoneNumberController,
                    hintText: "Contact Number",
                    IconSuffix: Icons.contact_page,
                    textInputType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: TextFormInputField(
                  readOnly: false,
                  controller: customerAddressController,
                  hintText: "Location",
                  textInputType: TextInputType.text,
                  IconSuffix: Icons.location_pin,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SaveButton(
                      title: "Edit Car",
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => EditCarProfile(
                                      uuid: data['uuid'],
                                    )));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
