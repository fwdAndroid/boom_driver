import 'package:boom_driver/cars/add_car.dart';
import 'package:boom_driver/screens/verification/final_call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Waiting"),
      ),
    );
  }

  void checkStatus() async {
    try {
      // Fetch the status from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth
              .instance.currentUser!.uid) // Replace with your document ID
          .get();

      // Check if the status is allowed
      bool isAllowed = snapshot['isAllowed'] as bool;

      // Navigate to the appropriate page based on the status
      if (isAllowed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AddCar()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FinalCall()),
        );
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching status: $e');
      // Optionally, you can show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching status. Please try again.')),
      );
    }
  }
}
