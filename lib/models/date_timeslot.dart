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

class TimeSlotModel {
  TimeSlotModel({
    this.status,
    this.timeslots,
  });

  bool? status;
  Timeslots? timeslots;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        status: json["status"],
        timeslots: Timeslots.fromJson(json["timeslots"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "timeslots": timeslots!.toJson(),
      };
}

class Timeslots {
  Timeslots({
    this.am,
    this.pm,
  });

  List<String>? am;
  List<String>? pm;

  factory Timeslots.fromJson(Map<String, dynamic> json) => Timeslots(
        am: List<String>.from(json["am"].map((x) => x)),
        pm: List<String>.from(json["pm"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "am": List<dynamic>.from(am!.map((x) => x)),
        "pm": List<dynamic>.from(pm!.map((x) => x)),
      };
}
