import 'dart:typed_data';

import 'package:boom_driver/screens/main/main_dashboard.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/screens/widgets/text_form_field.dart';
import 'package:boom_driver/services/database_methods.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:boom_driver/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController passengersController = TextEditingController();
  TextEditingController registerController = TextEditingController();

  bool isAdded = false;
  String? _selectedValue = 'Yes';
  var uuid = Uuid().v4();
  //Image
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Car',
          style: TextStyle(color: colorWhite),
        ),
        iconTheme: IconThemeData(color: colorWhite),
        backgroundColor: mainBtnColor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              var snap = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => selectImage(),
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 59,
                                backgroundImage: MemoryImage(_image!))
                            : CircleAvatar(
                                radius: 59,
                                backgroundImage:
                                    AssetImage('assets/person.png'),
                              ),
                        Positioned(
                            bottom: -10,
                            left: 70,
                            child: IconButton(
                                onPressed: () => selectImage(),
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: colorBlack,
                                )))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                    child: Text(
                      "Car Name",
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextFormInputField(
                      controller: dateController,
                      hintText: "Car Name",
                      textInputType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                    child: Text(
                      "Registration Number",
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextFormInputField(
                      controller: registerController,
                      hintText: "Registration Name",
                      textInputType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                    child: Text(
                      "Number Plate",
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextFormInputField(
                      controller: timeController,
                      hintText: "Number Plate",
                      textInputType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                    child: Text(
                      "Number of Seats",
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextFormInputField(
                      controller: passengersController,
                      hintText: "Number of Seats",
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                    child: Text(
                      "AC",
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorBlack),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<String>(
                        value: 'Yes',
                        groupValue: _selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                      Text('Yes'),
                      Radio<String>(
                        value: 'No',
                        groupValue: _selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                  Center(
                      child: isAdded
                          ? Center(
                              child: CircularProgressIndicator(
                                color: mainBtnColor,
                              ),
                            )
                          : SaveButton(
                              title: "Send Request",
                              onTap: () async {
                                if (dateController.text.isEmpty) {
                                  showMessageBar(
                                      "Car Name is Required ", context);
                                } else if (timeController.text.isEmpty) {
                                  showMessageBar(
                                      "Number Plate is Required ", context);
                                } else {
                                  setState(() {
                                    isAdded = true;
                                  });

                                  // Calculate urgency multiplier based on current time and selected time

                                  String result =
                                      await DatabaseMethods().addCar(
                                    driverEmail: snap['email'],
                                    carName: dateController.text,
                                    plate: timeController.text,
                                    ac: _selectedValue!,
                                    seats: passengersController.text,
                                    driverName: snap['name'],
                                    registerNumber: registerController.text,
                                    file: _image!, // Pass your image data here
                                  );
                                  setState(() {
                                    isAdded = false;
                                  });
                                  // Handle the result accordingly
                                  if (result == 'success') {
                                    showMessageBar(
                                        "Car Added Successfully", context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => MainDashboard(),
                                      ),
                                    );
                                  } else {
                                    // Show an error message
                                    showMessageBar("Failed", context);
                                  }
                                }
                              }))
                ],
              );
            }),
      ),
    );
  }

  //Functions

  void showMessageBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
