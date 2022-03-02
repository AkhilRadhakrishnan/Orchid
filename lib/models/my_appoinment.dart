import 'package:flutter/material.dart';

class MyAppoinmentModel with ChangeNotifier {
  MyAppoinmentModel({
    // this.success,
    this.upcoming,
  });

  // bool? success;
  List<Upcoming>? upcoming;

  factory MyAppoinmentModel.fromJson(Map<String, dynamic> json) => MyAppoinmentModel(
    // success: json["success"],
    upcoming: List<Upcoming>.from(json["upcoming"].map((x) => Upcoming.fromJson(x))),
  );
}

class Upcoming {
  Upcoming({
    this.id,
    this.date,
    this.time,
    this.doctor,
    this.type,
  });

  int? id;
  String? date;
  String? time;
  String? doctor;
  String? type;

  factory Upcoming.fromJson(Map<String, dynamic> json) => Upcoming(
    id: json["id"],
    date: json["appointment_date"],
    time: json["app_time"],
    doctor: json["emp_name"],
    type: json["emp_designation"],
  );
}
