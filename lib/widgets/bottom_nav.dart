import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/views/edit_profile.dart';
import 'package:orchid/views/home_screen.dart';
import 'package:orchid/views/my_appointments.dart';
import '../util/shared_preferences_helper.dart';
import '../views/landing_page.dart';
import '../views/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPage = 0;

  final _pageOptions = [
    HomeScreen(),
    const Profile(),
    MyAppointments(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        elevation: 3.0,
        currentIndex: selectedPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined ), label: ''),
        ],
        onTap: (index) async {
          if (index == 1 || index == 2) {
            if (await SharedPreferencesHelper.getAccessToken() == null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LandingPage()));
            } else {
              setState(() {
                selectedPage = index;
              });
            }
          } else {
            setState(() {
              selectedPage = index;
            });
          }
        },
      ),
    );
  }
}
