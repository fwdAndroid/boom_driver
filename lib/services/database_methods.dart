import 'dart:typed_data';

import 'package:boom_driver/models/car_model.dart';
import 'package:boom_driver/services/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  Future<String> addCar(
      {required String driverEmail,
      required String carName,
      required String plate,
      required String ac,
      required String seats,
      required String driverName,
      required String driverPhoto,
      required String registerNumber,
      required Uint8List file}) async {
    String res = 'Wrong driverEmail or carNameword';
    try {
      String carPhoto = await StorageMethods().uploadImageToStorage(
        'ProfilePics',
        file,
      );

      var uuid = Uuid().v4();
      //Add User to the database with modal
      CarModel userModel = CarModel(
          registerNumber: registerNumber,
          driverName: driverName,
          driverId: FirebaseAuth.instance.currentUser!.uid,
          plate: plate,
          carPhoto: carPhoto,
          driverEmail: driverEmail,
          seats: seats,
          carName: carName,
          ac: ac,
          uuid: uuid,
          driverPhoto: driverPhoto);
      await FirebaseFirestore.instance
          .collection('cars')
          .doc(uuid)
          .set(userModel.toJson());
      res = 'sucess';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
