import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TextEditingValue formatDate(DateTime dateValue) {
  return TextEditingValue(text: DateFormat.yMMMEd().format(dateValue));
}

String formatTime(TimeOfDay dateValue, BuildContext context) {
  DateTime parsedTime =
  DateFormat.jm().parse(dateValue.format(context).toString());
  String formattedTime = DateFormat('HH:mm').format(parsedTime);
  return formattedTime;
}