import 'dart:math';

import 'package:intl/intl.dart';

class DataConvert {
  static String toLocalDate(String date) {
    try {
      var dateValue = DateTime.parse(date);
      var formattedDate = DateFormat('yyyy-MM-dd').format(dateValue);
      return formattedDate;
    } on Exception {
      return '';
    }
  }

  static String toLocalDateWithMinute(String date) {
    try {
      var dateValue = DateTime.parse(date);
      // var dateValue = DateTime.parse(date).toLocal();
      var formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(dateValue);
      return formattedDate;
    } on Exception {
      return '';
    }
  }

  static String toLocalDateWithSeconds(String date) {
    try {
      var dateValue = DateTime.parse(date);
      var formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(dateValue);
      return formattedDate;
    } on Exception {
      return '';
    }
  }

  static String toGapTimewithNow(String uploadedTime) {
    DateTime now = DateTime.now();
    DateTime dt = DateTime.parse(uploadedTime);
    int gapMinutes = now.difference(dt).inMinutes;
    int gapHours = now.difference(dt).inHours;
    int gapDays = now.difference(dt).inDays;
    if (gapMinutes < 60) {
      return (gapMinutes.toString() + '분 전');
    } else if (gapHours < 24) {
      return (gapHours.toString() + '시간 전');
    } else {
      return (gapDays.toString() + '일 전');
    }
  }

  static double roundDouble(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }
}
