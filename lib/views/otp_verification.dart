import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/services/repository.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/widgets/bottom_nav.dart';
import 'package:orchid/widgets/otp_input.dart';

class OtpVerification extends StatefulWidget {
  String mobile;
  OtpVerification({Key? key, required this.mobile}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;
  String _timerValue = "";
  late Timer _timer;

  @override
  void initState() {
    setTimerValue();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, bottom: 15, top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verify Account!',
                style: TextStyle(fontSize: 25, color: Colors.grey.shade700)),
            sizedBox,
            Text(
                'Please enter 4 digit verification code send by SMS on your mobile number',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),

            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/mobilehand.png",
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Implement 4 input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_fieldOne, true),
                OtpInput(_fieldTwo, false),
                OtpInput(_fieldThree, false),
                OtpInput(_fieldFour, false)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _otp = _fieldOne.text +
                      _fieldTwo.text +
                      _fieldThree.text +
                      _fieldFour.text;
                });
                validateOtp();
              },
              child: const Text('Verify', style: TextStyle(fontSize: 18)),
              style: elevatedButton(MediaQuery.of(context).size.width),
            ),
            const SizedBox(
              height: 30,
            ),
            // Display the entered OTP code
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (_timerValue == "00:00") {
                    ResendOtp();
                  }
                },
                child: const Text(
                  "Resend",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            sizedBox,
            Align(
              alignment: Alignment.center,
              child: Text(
                _timerValue,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setTimerValue() {
    int timerValue = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerValue--;
      if (timerValue <= 0) {
        _timer.cancel();
      }
      setState(() {
        _timerValue = "00:" +
            (timerValue < 10
                ? "0" + timerValue.toString()
                : timerValue.toString());
      });
    });
  }

  void ResendOtp() {
    setTimerValue();
  }

  validateOtp() async {
    final res = await Repository()
        .validateOtp(mobile: widget.mobile, otp: _otp); // API Call
    if (res["status"]) {
      SharedPreferencesHelper.saveAccessToken(res["access_token"]);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } else {
      return "User not exist";
    }
  }
}
