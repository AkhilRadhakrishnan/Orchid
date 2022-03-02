import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/widgets/bottom_nav.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool obscurePwd = true;

  TextEditingController name = TextEditingController();
  TextEditingController pwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Card(),
                const Text("Orchid"),
                SizedBox(height: MediaQuery.of(context).size.height*0.3,),
                TextFormField(
                  controller: pwd,
                  cursorColor: Colors.black,
                  textCapitalization: TextCapitalization.sentences,
                  obscureText: obscurePwd,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundColor,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 28,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          obscurePwd
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePwd = !obscurePwd;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color:  Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: borderSide),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Password',
                  ),
                  // The validator receives the text that the user has entered.
                  // validator:requiredValidator,
                ),
                sizedBox,
                TextFormField(
                  controller: pwd,
                  cursorColor: Colors.black,
                  textCapitalization: TextCapitalization.sentences,
                  obscureText: obscurePwd,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundColor,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 28,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          obscurePwd
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePwd = !obscurePwd;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color:  Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: borderSide),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Confirm Password',
                  ),
                  // The validator receives the text that the user has entered.
                  // validator:requiredValidator,
                ),
                sizedBox,
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBar()));
                  },
                  child: const Text("Reset Password"),
                  style: elevatedButton(MediaQuery.of(context).size.width ),
                )
              ])),
    );
  }
}
