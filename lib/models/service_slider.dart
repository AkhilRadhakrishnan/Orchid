import 'package:flutter/material.dart';

class ServiceSliderModel with ChangeNotifier {
  ServiceSliderModel({
    // this.success,
    this.serviceSliders,
  });

  // bool? success;
  List<ServiceSliders>? serviceSliders;

  factory ServiceSliderModel.fromJson(Map<String, dynamic> json) => ServiceSliderModel(
    // success: json["success"],
    serviceSliders: List<ServiceSliders>.from(
        json["services_slider"].map((x) => ServiceSliders.fromJson(x))),
  );
}

class ServiceSliders {
  ServiceSliders({
    this.id,
    this.image,
    this.titileText,
    this.subText,
  });

  int? id;
  String? image;
  String? titileText;
  String?  subText;

  factory ServiceSliders.fromJson(Map<String, dynamic> json) => ServiceSliders(
    id: json["id"],
    image: json["image"],
    titileText: json["titileText"],
    subText: json["subText"],

  );
}
