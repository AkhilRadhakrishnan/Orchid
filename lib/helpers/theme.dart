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

SnackBar resSnackBar(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: isError ? Colors.red.shade800 : primaryColor,
    elevation: 5,
    duration: const Duration(seconds: 2),
  );
}

InputDecoration inputTextDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(color: bodyTextColor),
    borderRadius: BorderRadius.circular(10),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: bodyTextColor),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: borderSide),
    borderRadius: BorderRadius.circular(10),
  ),
  contentPadding: const EdgeInsets.all(12),
);
