import 'dart:math';

import 'package:intl/intl.dart';

class DataConvert {
  static String toLocalDate(String utcDate) {
    try {
      var dateValue =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parseUTC(utcDate).toLocal();
      var formattedDate = DateFormat('yyyy-MM-dd').format(dateValue);
      return formattedDate;
    } on Exception {
      return '';
    }
  }

  static String toLocalDateWithMinute(String utcDate) {
    try {
      var dateValue =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parseUTC(utcDate).toLocal();
      var formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(dateValue);
      return formattedDate;
    } on Exception {
      return '';
    }
  }

  static String toLocalDateWithSeconds(String utcDate) {
    try {
      var dateValue =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parseUTC(utcDate).toLocal();
      var formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(dateValue);
      return formattedDate;
    } on Exception {
      return '';
    }
  }

  static double roundDouble(double value, int places) {
    return double.parse(value.toStringAsFixed(places));
  }
}
