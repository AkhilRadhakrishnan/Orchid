import 'package:flutter/material.dart';

class MyAppoinmentUpcomingModel with ChangeNotifier {
  MyAppoinmentUpcomingModel(
      {
      // this.success,
      this.appointmentUpcoming});

  // bool? success;
  List<Appointment>? appointmentUpcoming;

  factory MyAppoinmentUpcomingModel.fromJson(Map<String, dynamic> json) =>
      MyAppoinmentUpcomingModel(
          // success: json["success"],
          appointmentUpcoming: List<Appointment>.from(
              json["upcoming"]!.map((x) => Appointment.fromJson(x))));
}

class MyAppoinmentPastModel with ChangeNotifier {
  MyAppoinmentPastModel(
      {
      // this.success,
      this.appointmentPast});

  // bool? success;
  List<Appointment>? appointmentPast;

  factory MyAppoinmentPastModel.fromJson(Map<String, dynamic> json) =>
      MyAppoinmentPastModel(
          // success: json["success"],
          appointmentPast: List<Appointment>.from(
              json["past"]!.map((x) => Appointment.fromJson(x))));
}

class Appointment {
  Appointment(
      {this.id,
      this.date,
      this.time,
      this.dr_id,
      this.doctor,
      this.type,
      this.image,
      this.speciality,
      this.description});

  String? id;
  String? date;
  String? time;
  String? dr_id;
  String? doctor;
  String? type;
  String? image;
  String? speciality;
  String? description;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
      id: json["app_id"],
      date: json["appointment_date"],
      time: json["app_time"],
      dr_id: json['dr_id'],
      doctor: json["name"],
      type: json["designation"],
      image: json["image"],
      speciality: json["speciality"],
      description: json["description"]);
}
