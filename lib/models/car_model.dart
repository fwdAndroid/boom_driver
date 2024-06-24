import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String driverId;
  String driverName;
  String driverEmail;
  String carName;
  String driverPhoto;
  String plate;
  String ac;
  String seats;
  String uuid;
  String registerNumber;

  CarModel({
    required this.driverId,
    required this.driverName,
    required this.ac,
    required this.driverEmail,
    required this.registerNumber,
    required this.driverPhoto,
    required this.uuid,
    required this.plate,
    required this.seats,
    required this.carName,
  });

  ///Converting Object into Json Object
  Map<String, dynamic> toJson() => {
        'carName': carName,
        'ac': ac,
        "registerNumber": registerNumber,
        'driverId': driverId,
        'driverName': driverName,
        "seats": seats,
        'driverEmail': driverEmail,
        'location': uuid,
        'plate': plate,
        'driverPhoto': driverPhoto,
        'uuid': uuid,
      };

  ///
  static CarModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return CarModel(
      carName: snapshot['carName'],
      registerNumber: snapshot['registerNumber'],
      seats: snapshot['seats'],
      driverId: snapshot['driverId'],
      ac: snapshot['ac'],
      driverName: snapshot['driverName'],
      driverPhoto: snapshot['driverPhoto'],
      uuid: snapshot['uuid'],
      driverEmail: snapshot['driverEmail'],
      plate: snapshot['plate'],
    );
  }
}
