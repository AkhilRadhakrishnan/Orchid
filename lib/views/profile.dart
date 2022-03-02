import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/services/repository.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/views/forgot_password.dart';
import 'package:orchid/views/my_appoinments.dart';
import 'package:orchid/views/notification_page.dart';
import 'package:orchid/widgets/bottom_nav.dart';

import 'otp_verification.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final dateController = TextEditingController();
  String dropdownvalue = 'Male';
  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedBox,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/user.png',
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  sizedBox,
                  const Text(
                    "Akhil Radhakrishnan",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    "akhiler@gmail.com",
                    style: TextStyle(fontSize: 12),
                  ),
                  const Text(
                    "+974 52468 15545",
                    style: TextStyle(fontSize: 12),
                  ),
                  sizedBox,
                  const Text(
                    "lorem ipsum sample document",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            sizedBox,
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.height,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "My Appointments",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppoinment()),
                );
              },
            ),
            sizedBox,
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.height,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text(
                  "My Notifications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()),
                );
              },
            ),
            sizedBox,
            InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.height,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Text(
                    "Logout",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  )),
              onTap: () {
                onLogout();
              },
            )
          ])),
    );
  }

  void onLogout() {
    // logout api
  }
}
