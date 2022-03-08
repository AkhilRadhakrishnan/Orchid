import 'package:flutter/material.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/views/login.dart';
import 'package:orchid/widgets/bottom_nav.dart';


class LandingPage extends StatelessWidget {

   LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 100),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    )),
                    child: Image.asset('assets/images/orchid.png',
                        width: 100, height: 100)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Orchid",
                  style: TextStyle(fontSize: 25, color: Colors.grey.shade700),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome to Orchid",
                  style: TextStyle(fontSize: 27, color: Colors.grey.shade700),
                ),
                Text(
                  "Medical Center",
                  style: TextStyle(fontSize: 27, color: Colors.grey.shade700),
                ),
                sizedBox,
                Text("Providing Quality Care in Dermatology and Cosmetology,",
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                Text("Family Medicine, Gynecology, and Dietetics in Doha",
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  LoginPage( loginView: false)));
                  },
                  child: const Text("Register", style: TextStyle(fontSize: 18)),
                  style: elevatedButton(MediaQuery.of(context).size.width),
                ),
                sizedBox,
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(loginView: true,)));
                    },
                    child: const Text("Login", style: TextStyle(fontSize: 18)),
                    style: elevatedButton(MediaQuery.of(context).size.width)),
              ])),
    );
  }
}
