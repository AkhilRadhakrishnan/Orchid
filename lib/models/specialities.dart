
import 'package:flutter/material.dart';

class SpecialitiesModel with ChangeNotifier {
  SpecialitiesModel({
    // this.success,
    this.specialities,
  });

  // bool? success;
  List<Specialities>? specialities;

  factory SpecialitiesModel.fromJson(Map<String, dynamic> json) => SpecialitiesModel(
    // success: json["success"],
    specialities: List<Specialities>.from(
        json["specialities_list"].map((x) => Specialities.fromJson(x))),
  );
}

class Specialities {
  Specialities({
    this.id,
    this.icon,
    this.image,
    this.title,
    this.color,
  });

  int? id;
  String? icon;
  String? image;
  String? title;
  String?  color;

  factory Specialities.fromJson(Map<String, dynamic> json) => Specialities(
    id: json["id"],
    icon: json["icon"],
    image: json["image"],
    title: json["titile"],
    color: json["color"],
  );
}
