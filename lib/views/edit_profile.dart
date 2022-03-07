import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final dateController = TextEditingController();
  String dropdownvalue = 'Male';
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  set _imageFile(XFile? value) {
    imageFile = value;
  }

  dynamic _pickImageError;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
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
      body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
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
                            height: MediaQuery.of(context).size.width * 0.25,
                          )
                        : Image.file(
                            File(imageFile!.path),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
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
                        value: dropdownvalue,
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
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
                      controller: dateController,
                      decoration: inputTextDecoration,
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        dateController.text = date.toString().substring(0, 10);
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
              onPressed: () {},
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              style: elevatedButton(MediaQuery.of(context).size.width),
            )
          ])),
    );
  }
}
