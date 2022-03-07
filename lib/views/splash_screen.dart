import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/custom_route.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _width = 100;
  double _height = 100;
  late Timer _timer;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          FadePageRoute(builder: (context) => const BottomNavBar()));
    });

    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      _width = 200;
      _height = 200;
      _timer.cancel();
    });

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
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          child: AnimatedContainer(
            height: _height,
            width: _width,
            curve: Curves.bounceInOut,
            decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage("assets/images/orchid.png"),
                    fit: BoxFit.scaleDown)),
            duration: const Duration(seconds: 2),
          )),
    );
  }
}
