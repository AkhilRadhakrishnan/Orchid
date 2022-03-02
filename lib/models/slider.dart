import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  SliderModel({
    // this.success,
    this.sliders,
  });

  // bool? success;
  List<Sliders>? sliders;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    // success: json["success"],
    sliders: List<Sliders>.from(
        json["slider_main"].map((x) => Sliders.fromJson(x))),
  );
}

class Sliders {
  Sliders({
    this.id,
    this.image,
    this.imgaeQuote,
    this.bookText,
    this.buttonText
  });

  int? id;
  String? image;
  String? imgaeQuote;
  String?  bookText;
  String?  buttonText;

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
    id: json["id"],
    image: json["image"],
    imgaeQuote: json["imgaeQuote"],
    bookText: json["bookText"],
    buttonText: json["buttonText"],
  );
}
