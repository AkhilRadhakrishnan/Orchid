import 'package:flutter/material.dart';

class ServicesModel with ChangeNotifier {
  ServicesModel({
    // this.success,
    this.services,
  });

  // bool? success;
  List<Services>? services;

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        // success: json["success"],
        services: List<Services>.from(
            json["main service"].map((x) => Services.fromJson(x))),
      );
}

class Services {
  Services({
    this.id,
    this.image,
    this.text,
    this.title,
    this.icon,
  });

  String? id;
  String? image;
  String? text;
  String? title;
  String? icon;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        id: json["id"],
        image: json["image"],
        text: json["text"],
        title: json["titile"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'text': text,
      'titile': title,
      'icon': icon,
    };
  }
}

// List<Services> servicesList = [
//   Services(
//     image: 'assets/images/skincare.jpg',
//     name: "Aesthetic and skin care Clinic",
//   ),
//   Services(
//     image: 'assets/images/antiaging.png',
//     name: "Anti-aging Clinic",
//   ),
//   Services(
//     image: 'assets/images/hair-loss-treatment-clinic-1.png',
//     name: "Hair Care Clinic",
//   )
// ];

class ServiceDetails {
  final String name;
  final String image;
  final Color color;
  final Color textColor;
  ServiceDetails(
      {required this.image,
      required this.name,
      required this.color,
      required this.textColor});
}
