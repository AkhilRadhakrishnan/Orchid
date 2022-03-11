import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/services/repository.dart';
import 'package:orchid/views/landing_page.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _name, _mail, _mobile;
  bool loginView = false;
  bool isLoading = false;

  @override
  void initState() {
    loginView = widget.loginView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 50),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/orchid.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  sizedBox,
                  if (!loginView)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email *',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  sizedBox,
                  if (!loginView)
                    TextFormField(
                      controller: mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      decoration: inputTextDecoration,
                      onSaved: (String? val) {
                        _mail = val;
                      },
                    ),
                  sizedBox,
                  if (!loginView)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name *',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  if (!loginView) sizedBox,
                  if (!loginView)
                    TextFormField(
                      controller: name,
                      validator: validateName,
                      onSaved: (String? val) {
                        _name = val;
                      },
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
                          validator: validateMobile,
                          keyboardType: TextInputType.number,
                          onSaved: (String? val) {
                            _mobile = val;
                          },
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
                    onPressed: isLoading
                        ? null
                        : () {
                            _validateInputs();
                          },
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    style: elevatedButton(MediaQuery.of(context).size.width),
                  ),
                  sizedBox,
                  InkWell(
                      onTap: () {
                        setState(() {
                          loginView = !loginView;
                        });
                      },
                      child: Text(
                        loginView ? "Register" : "Login",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      )),
                ]),
          )),
    );
  }

  onLoginorRegister() async {
    setState(() {
      isLoading = true;
    });
    dynamic res;
    if (loginView) {
      res = await Repository().validateLogin(mobile: mobile.text); // API Call
    } else {
      var data = {
        "cust_name": name.text,
        "email": mail.text,
        "contact_no": mobile.text,
        // "password": "123456789"
      };
      res = await Repository().validateRegister(data: data); //
    }
    if (res["status"]) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OtpVerification(mobile: mobile.text)));
    } else {
      var snackBar = resSnackBar(res['message'], true);
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar)
          .closed
          .then((value) => {setState(() => isLoading = false)});
    }
  }

  String? validateName(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 3 characters';
    }
    return null;
  }

  String? validateMobile(String? value) {
    // String pattern = r'(^(?:[+0]9)?[0-9]{8}$)';
    // String pattern = r'^(([^(\d{8}(\,\d{8}){0,2}]))$';
    String pattern = r'(^(\d{8}(\,\d{8}){0,2})$)';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter Valid Mobile number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Please enter Valid Email';
    }
    return null;
  }

  void _validateInputs() {
    //If all data are correct then save data to out variables
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      onLoginorRegister();
    }
    _formKey.currentState!.save();
  }
}
