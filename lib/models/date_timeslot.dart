import 'dart:convert';
import 'package:flutter/material.dart';

class DateModel with ChangeNotifier {
  DateModel({
    // this.success,
    this.holidays,
  });

  // bool? success;
  List<Holidays>? holidays;

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        // success: json["success"],
        holidays: List<Holidays>.from(
            json["holidays"].map((x) => Holidays.fromJson(x))),
      );
}

class Holidays {
  Holidays({this.id, this.date, this.content});

  String? id;
  String? date;
  String? content;

  factory Holidays.fromJson(Map<String, dynamic> json) =>
      Holidays(id: json["id"], date: json["date"], content: json["content"]);
}

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

class TimeSlotModel with ChangeNotifier {
  TimeSlotModel({
    this.am,
    this.pm,
  });

  List<String>? am;
  List<String>? pm;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        am: List<String>.from(json["am"].map((x) => x)),
        pm: List<String>.from(json["pm"].map((x) => x)),
      );
}
