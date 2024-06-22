import 'dart:typed_data';

import 'package:boom_driver/screens/verification/ready.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DriverVerification extends StatefulWidget {
  const DriverVerification({super.key});

  @override
  State<DriverVerification> createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(9),
            child: ListTile(
              title: Text("Let’s Upload your driver license"),
              subtitle: Text(
                  "Uploade a legible picture of your driver license to verify it"),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: selectImage,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _image != null
                  ? CircleAvatar(
                      radius: 59, backgroundImage: MemoryImage(_image!))
                  : Image.asset("assets/frame.png"),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: SaveButton(
                  title: "Next",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Ready()));
                  }),
            ),
          )
        ],
      ),
    );
  }

  //Fucctions
  /// Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
