import 'package:flutter/material.dart';
import 'colors.dart';

InputBorder searchTextBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: Colors.grey),
  borderRadius: BorderRadius.circular(5),
);

const Widget sizedBox = SizedBox(height: 10.0);

ButtonStyle elevatedButton(width) {
  return ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: primaryColor,
    elevation: 0,
    fixedSize: Size(width, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );
}

InputDecoration inputTextDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(color: bodyTextColor),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: borderSide),
    borderRadius: BorderRadius.circular(10),
  ),
  contentPadding: const EdgeInsets.all(12),
);

