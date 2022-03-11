import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/services/repository.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/views/edit_profile.dart';
import 'package:orchid/views/my_appointments.dart';
import 'package:orchid/views/splash_screen.dart';
import 'package:orchid/widgets/bottom_nav.dart';

import '../models/authentication.dart';

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
  String dropdownValue = 'Male';
  User userDetails = User();
  String? accessToken = "";

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    User user = await SharedPreferencesHelper.getUserDetails();
    String? at = await SharedPreferencesHelper.getAccessToken();
    setState(() {
      userDetails = user;
      accessToken = at;
    });
  }

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
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: bodyTextColor,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            },
          ),
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
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
                  Text(
                    ((userDetails.name == "" || userDetails.name == null)
                        ? ''
                        : userDetails.name!),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    ((userDetails.email == "" || userDetails.email == null)
                        ? ''
                        : userDetails.email!),
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    ((userDetails.contactNo == "" ||
                            userDetails.contactNo == null)
                        ? ''
                        : userDetails.contactNo!),
                    style: const TextStyle(fontSize: 12),
                  ),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('File No: '),
                      Text(
                        ((userDetails.fileNo == "" ||
                                userDetails.fileNo == null)
                            ? ''
                            : userDetails.fileNo!),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
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
                  "Edit Profile",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
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
                  MaterialPageRoute(builder: (context) => MyAppointments()),
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

  void onLogout() async {
    var res = await Repository().logout();
    if (res['status']) {
      var snackBar =
      resSnackBar('Logout Successfully!',false);
      SharedPreferencesHelper.clearAll();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => SplashScreen()), (route) => false);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => SplashScreen()));
    }
  }
}
