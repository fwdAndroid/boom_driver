import 'dart:typed_data';

import 'package:boom_driver/screens/verification/final_call.dart';
import 'package:boom_driver/screens/widgets/save_button.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:boom_driver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Ready extends StatefulWidget {
  const Ready({super.key});

  @override
  State<Ready> createState() => _ReadyState();
}

class _ReadyState extends State<Ready> {
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
              title: Text(
                "Your are Ready to Drive",
                style: TextStyle(
                    color: colorBlack,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your account is  now activated. Let’s book your load.",
              style: TextStyle(
                  color: colorBlack, fontSize: 15, fontWeight: FontWeight.w200),
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
                        MaterialPageRoute(builder: (builder) => FinalCall()));
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
