import 'package:boom_driver/screens/main/account_page.dart';
import 'package:boom_driver/screens/main/chat_page.dart';
import 'package:boom_driver/screens/main/home_page.dart';
import 'package:boom_driver/screens/main/trips_page.dart';
import 'package:boom_driver/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    Trips(),
    ChatPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Color(0xffF4721E)),
        backgroundColor: mainBtnColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Color(0xffF4721E) : textformColor,
            ),
            label: 'Home',
            backgroundColor: mainBtnColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trip_origin,
              color: _currentIndex == 1 ? Color(0xffF4721E) : textformColor,
            ),
            label: 'Chat',
            backgroundColor: mainBtnColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_rounded,
              color: _currentIndex == 2 ? Color(0xffF4721E) : textformColor,
            ),
            label: 'Chat',
            backgroundColor: mainBtnColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3 ? Color(0xffF4721E) : textformColor,
            ),
            label: 'Account',
            backgroundColor: mainBtnColor,
          ),
        ],
      ),
    );
  }
}
