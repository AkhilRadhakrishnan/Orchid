import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/services/repository.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/views/forgot_password.dart';
import 'package:orchid/widgets/bottom_nav.dart';

import 'otp_verification.dart';

class LoginPage extends StatefulWidget {
  bool loginView;
  LoginPage({Key? key, required this.loginView}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mobile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 50),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/orchid.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
                sizedBox,
                if (!widget.loginView)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email *',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                sizedBox,
                if (!widget.loginView)
                  TextFormField(
                    controller: mail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputTextDecoration,
                  ),
                sizedBox,
                if (!widget.loginView)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name *',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                if (!widget.loginView) sizedBox,
                if (!widget.loginView)
                  TextFormField(
                    controller: name,
                    decoration: inputTextDecoration,
                  ),
                sizedBox,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mobile Number *',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .14,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(left: 12, top: 15),
                      child: const Text(
                        "+974",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .76,
                      child: TextFormField(
                        controller: mobile,
                        keyboardType: TextInputType.number,
                        decoration: inputTextDecoration,
                      ),
                    ),
                    sizedBox,
                  ],
                ),
                sizedBox,
                const Text(
                    '* We will send a 4 digit verification code by SMS on your mobile number.'),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    onLoginorRegister();
                  },
                  child: const Text(
                    "Continue",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  style: elevatedButton(MediaQuery.of(context).size.width),
                )
              ])),
    );
  }

  onLoginorRegister() async {
    dynamic res;
    if (widget.loginView) {
      res = await Repository().validateLogin(mobile: mobile.text); // API Call
    } else {
      var data = {
        "cust_name": name.text,
        "email": mail.text,
        "contact_no": mobile.text,
        "password": "123456789"
      };
      res = await Repository().validateRegister(data: data); //
    }
    if (res["status"]) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OtpVerification(mobile: mobile.text)));
    } else {
      return "User not exist";
    }

    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => OtpVerification(mobile: mobile.text)));
  }
}
