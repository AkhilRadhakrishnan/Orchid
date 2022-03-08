import 'package:flutter/material.dart';

class NurseModel with ChangeNotifier {
  NurseModel({
    // this.success,
    this.nurses,
  });

  // bool? success;
  List<Nurse>? nurses;

  factory NurseModel.fromJson(Map<String, dynamic> json) => NurseModel(
        // success: json["success"],
        nurses: List<Nurse>.from(json["Nurse"].map((x) => Nurse.fromJson(x))),
      );
}

class Nurse {
  Nurse({
    this.id,
    this.name,
    this.image,
    this.speciality,
    this.experience,
  });

  String? id;
  String? name;
  String? image;
  String? speciality;
  String? experience;

  factory Nurse.fromJson(Map<String, dynamic> json) => Nurse(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        speciality: json["speciality"],
        experience: json["experiance"],
      );
}
