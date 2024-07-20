import 'package:boom_driver/screens/auth/auth_login.dart';
import 'package:boom_driver/screens/edit/account_info.dart';
import 'package:boom_driver/screens/main/car_info.dart';
import 'package:boom_driver/screens/main/chat_page.dart';
import 'package:boom_driver/screens/main/earning_records.dart';
import 'package:boom_driver/screens/main/location_info.dart';
import 'package:boom_driver/screens/main/privacy.dart';
import 'package:boom_driver/screens/main/ride_history.dart';
import 'package:boom_driver/screens/main/ride_setting.dart';
import 'package:boom_driver/screens/notificaiton/notifications.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style:
                          GoogleFonts.inter(color: mainBtnColor, fontSize: 18),
                    ),
                    Icon(
                      Icons.search,
                      color: mainBtnColor,
                    )
                  ],
                ),
              ),
              StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No data available'));
                    }
                    var snap = snapshot.data;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snap['photoURL']),
                      ),
                      title: Text(
                        snap['fullName'],
                        style: GoogleFonts.inter(
                            color: mainBtnColor, fontSize: 15),
                      ),
                      subtitle: Text(
                        "Trust your feelings , be a good human beings",
                        style: GoogleFonts.inter(
                            color: secondaryTextColor, fontSize: 12),
                      ),
                    );
                  }),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AccountInfo()));
                },
                leading: Icon(
                  Icons.person,
                  color: dividerColor,
                ),
                title: Text(
                  "Account",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => LocationInfo()));
                },
                leading: Icon(
                  Icons.location_pin,
                  color: dividerColor,
                ),
                title: Text(
                  "Locations",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CarInfo()));
                },
                leading: Icon(
                  Icons.taxi_alert,
                  color: dividerColor,
                ),
                title: Text(
                  "Cars",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => RideHistory()));
                },
                leading: Icon(
                  Icons.history,
                  color: dividerColor,
                ),
                title: Text(
                  "Ride History",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => NotificationScreen()));
                },
                leading: Icon(
                  Icons.notifications,
                  color: dividerColor,
                ),
                title: Text(
                  "Notifications",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => ChatPage()));
                },
                leading: Icon(
                  Icons.chat_bubble,
                  color: dividerColor,
                ),
                title: Text(
                  "Chat",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => CustomerPrivacyPolicy()));
                },
                leading: Icon(
                  Icons.privacy_tip,
                  color: dividerColor,
                ),
                title: Text(
                  "Privacy and Security",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                leading: Icon(
                  Icons.money,
                  color: dividerColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => EarningsScreen()));
                },
                title: Text(
                  "Earning Records",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => RideSetting()));
                },
                leading: Icon(
                  Icons.local_taxi,
                  color: dividerColor,
                ),
                title: Text(
                  "Ride Setting",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AuthLogin()));
                },
                leading: Icon(
                  Icons.logout,
                  color: dividerColor,
                ),
                title: Text(
                  "Logout",
                  style: GoogleFonts.inter(
                      color: secondaryTextColor, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
