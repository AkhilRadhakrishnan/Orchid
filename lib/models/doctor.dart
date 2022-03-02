import 'package:flutter/material.dart';

class DoctorModel with ChangeNotifier {
  DoctorModel({
    // this.success,
    this.doctors,
  });

  // bool? success;
  List<Doctor>? doctors;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    // success: json["success"],
    doctors: List<Doctor>.from(
        json["doc"].map((x) => Doctor.fromJson(x))),
  );
}

class Doctor {
  Doctor({
    this.id,
    this.name,
    this.image,
    this.experience,
    this.patients,
    this.speciality,
    this.description,
  });

  String? id;
  String? name;
  String? image;
  String? experience;
  String? patients;
  String? speciality;
  String? description;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    experience: json["experiance"],
    patients: json["patients"],
    speciality: json["speciality"],
    description: json["description"],
  );

}

// List<Doctor> doctorList = [
//   Doctor(
//       name: "Dr. Amal",
//       image:
//       "assets/images/dramal.png"),
//   Doctor(
//       name: "Dr. Meenakshi Sekhar",
//       image: "assets/images/drmeenakshi.png"),
//   Doctor(
//       name: "Dr. Khalid",
//       image: "assets/images/drkhalid.png"),
//   Doctor(
//       name: "Dr. Amal",
//       image:
//       "assets/images/dramal.png"),
// ];
