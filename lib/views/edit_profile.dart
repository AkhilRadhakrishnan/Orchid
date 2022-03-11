import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchid/views/home_screen.dart';

import '../models/authentication.dart';
import '../services/repository.dart';
import '../util/shared_preferences_helper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User userDetails = User();
  String? accessToken = "";
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController dobDate = TextEditingController();
  String genderValue = 'Male';
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  bool isLoading = false;

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
      name.text = (userDetails.name == '' || userDetails.name == null)
          ? ''
          : userDetails.name!;
      mail.text = (userDetails.email == '' || userDetails.email == null)
          ? ''
          : userDetails.email!;
      mobile.text =
          (userDetails.contactNo == '' || userDetails.contactNo == null)
              ? ''
              : userDetails.contactNo!;
      genderValue = (userDetails.gender == '' || userDetails.gender == null)
          ? 'Male'
          : userDetails.gender!;
      dobDate.text = (userDetails.dob == '' || userDetails.dob == null)
          ? ''
          : userDetails.dob!;
    });
  }

  set _imageFile(XFile? value) {
    imageFile = value;
  }

  dynamic _pickImageError;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dobDate.dispose();
    super.dispose();
  }

  void _onImageButtonPressed(BuildContext? context) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight:40,
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: bodyTextColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
        ),
      ),
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: imageFile == null
                            ? Image.asset(
                                'assets/images/user.png',
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                              )
                            : Image.file(
                                File(imageFile!.path),
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                              ),
                      ),
                      sizedBox,
                      InkWell(
                          child: const Text(
                            "Edit Profile Image",
                            style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            _onImageButtonPressed(context);
                          }),
                    ],
                  ),
                ),
                sizedBox,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email *',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                sizedBox,
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    enabled: false,
                    controller: mail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputTextDecoration,
                  ),
                ),
                sizedBox,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name *',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                sizedBox,
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: name,
                    decoration: inputTextDecoration,
                  ),
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
                SizedBox(
                  height: 40,
                  child: Row(
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
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .77,
                        child: TextFormField(
                          enabled: false,
                          controller: mobile,
                          keyboardType: TextInputType.number,
                          decoration: inputTextDecoration,
                        ),
                      ),
                      sizedBox,
                    ],
                  ),
                ),
                sizedBox,
                Row(
                  children: [
                    const Text(
                      'Gender *',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.22),
                    const Text(
                      'DOB *',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                sizedBox,
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width * .25,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            value: genderValue,
                            items: <String>['Male', 'Female', 'Others']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                genderValue = newValue!;
                              });
                            },
                          )
                          // TextFormField(
                          //   controller: name,
                          //   decoration: inputTextDecoration,
                          // ),
                          ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .59,
                        child: TextFormField(
                          readOnly: true,
                          controller: dobDate,
                          decoration: inputTextDecoration,
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            dobDate.text = date.toString().substring(0, 10);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // const Text(
                //     '* We will send a 4 digit verification code by SMS on your mobile number.'),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          saveProfile();
                        },
                  child: const Text(
                    "Save",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  style: elevatedButton(MediaQuery.of(context).size.width),
                ),
              ])),
    );
  }

  saveProfile() async {
    setState(() {
      isLoading = true;
    });
    var data = {
      "cust_name": name.text,
      "gender": genderValue,
      "dob": dobDate.text
    };

    dynamic res = await Repository().editUser(data: data);
    var snackBar;
    if (res['status']) {
      userDetails.name = name.text;
      userDetails.gender = genderValue;
      userDetails.dob = dobDate.text;
      await SharedPreferencesHelper.saveUserDetails(userDetails);
      snackBar = resSnackBar('Your profile details has been updated!', false);
    } else {
      snackBar = resSnackBar(res['message'], true);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((value) => {setState(() => isLoading = false)});
  }
}
