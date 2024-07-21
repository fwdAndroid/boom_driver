import 'dart:typed_data';

import 'package:boom_driver/screens/main/main_dashboard.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/screens/widgets/text_form_field.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:boom_driver/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditCarProfile extends StatefulWidget {
  final uuid;
  const EditCarProfile({super.key, required this.uuid});

  @override
  State<EditCarProfile> createState() => _EditCarProfileState();
}

class _EditCarProfileState extends State<EditCarProfile> {
  TextEditingController carNameController = TextEditingController();
  TextEditingController carRegisterNumberController = TextEditingController();
  TextEditingController carSeatsController = TextEditingController();
  TextEditingController plate = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // Fetch data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('cars')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched data
    setState(() {
      carNameController.text = data['carName'];
      carRegisterNumberController.text = data['registerNumber'];
      carSeatsController.text = data['seats'].toString();
      imageUrl = data['carPhoto'];
      plate = data['plate'];
    });
  }

  Future<void> selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('cars')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
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
            "Edit Car",
            style: GoogleFonts.workSans(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: mainBtnColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: _image != null
                      ? CircleAvatar(
                          radius: 59, backgroundImage: MemoryImage(_image!))
                      : imageUrl != null
                          ? CircleAvatar(
                              radius: 59,
                              backgroundImage: NetworkImage(imageUrl!))
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/Choose Image.png"),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                    controller: carNameController,
                    hintText: "Car Name",
                    IconSuffix: Icons.person,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: carRegisterNumberController,
                    hintText: "Register Number",
                    IconSuffix: Icons.contact_page,
                    textInputType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: TextFormInputField(
                  controller: carSeatsController,
                  hintText: "Car Seats",
                  textInputType: TextInputType.text,
                  IconSuffix: Icons.location_pin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: TextFormInputField(
                  controller: plate,
                  hintText: "Car Plate",
                  textInputType: TextInputType.text,
                  IconSuffix: Icons.location_pin,
                ),
              ),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: mainBtnColor,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SaveButton(
                            title: "Confirm",
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });

                              String? downloadUrl;
                              if (_image != null) {
                                downloadUrl =
                                    await uploadImageToStorage(_image!);
                              } else {
                                downloadUrl = imageUrl;
                              }

                              await FirebaseFirestore.instance
                                  .collection("cars")
                                  .doc(widget.uuid)
                                  .update({
                                "carName": carNameController.text.trim(),
                                "registerNumber":
                                    carRegisterNumberController.text.trim(),
                                "seats": carSeatsController.text.trim(),
                                "carPhoto": downloadUrl,
                                "plate": plate.text.trim()
                              });
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MainDashboard()));
                            }),
                      ),
              ),
            ],
          ),
        ));
  }
}
