import 'package:flutter/material.dart';
import 'package:orchid/views/edit_profile.dart';
import 'package:orchid/views/home_screen.dart';
import 'package:orchid/views/notification_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPage = 0;

  final _pageOptions = [
    HomeScreen(),
    const EditProfile(),
    const NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xff4d0000),
        elevation: 3.0,
        currentIndex: selectedPage,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.pink,
            ),
            icon: Icon(Icons.home, color: Colors.black38),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black38,
            ),
            activeIcon: Icon(
              Icons.person_outline,
              color: Color(0xff4d0000),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_rounded, color: Colors.black38),
            activeIcon: Icon(
              Icons.notification_add_rounded,
              color: Color(0xff4d0000),
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
