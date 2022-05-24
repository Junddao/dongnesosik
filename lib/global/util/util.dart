import 'package:dongnesosik/global/util/simple_logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:logger/logger.dart';
// import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'dart:developer' as developer;

var logger = Logger(
  printer: SimpleLogger(colors: false, printTime: true),
  // printer: PrettyPrinter(colors: false, printTime: true),
);
// var logger = Logger('Credi');

void initRootLogging() {
  // if (kDebugMode) {
  //   Logger.root.level = Level.ALL;
  // } else {
  //   Logger.root.level = Level.OFF;
  // }
  // hierarchicalLoggingEnabled = true;

  // // Logger.root.onRecord.listen((record) {
  // //   print(
  // //       '${record.time}: ${record.loggerName}: ${record.level.name}:  ${record.message}');
  // // });

  // Logger.root.onRecord.listen((record) {
  //   if (!kDebugMode) {
  //     return;
  //   }

  //   var start = '\x1b[90m';
  //   const end = '\x1b[0m';
  //   const white = '\x1b[37m';

  //   switch (record.level.name) {
  //     case 'INFO':
  //       start = '\x1b[37m';
  //       break;
  //     case 'FINE':
  //       start = '\x1B[38;2;150;150;150m';
  //       break;
  //     case 'WARNING':
  //       start = '\x1b[93m';
  //       break;
  //     case 'SEVERE':
  //       start = '\x1b[103m\x1b[31m';
  //       break;
  //     case 'SHOUT':
  //       start = '\x1b[41m\x1b[93m';
  //       break;
  //   }

  //   final message =
  //       '$white${record.time.toTimeString()}:$end$start[${record.level.name}] ${record.message}$end';
  //   developer.log(
  //     message,
  //     name: record.loggerName.padRight(10),
  //     level: record.level.value,
  //     time: record.time,
  //   );
  // });
}
void initRootLogger() {}

// /// Returns the current line number of the calling code.
// ///
// /// Returns -1 on failure.
// int get lineNumber {
//   // Frame #1 is our caller.
//   //
//   // Example line to parse:
//   // #1      someFunction (package:somePackage/someFile.dart:123:45)
//   final re = RegExp(r'^#1[ \t]+.+:(?<line>[0-9]+):[0-9]+\)$', multiLine: true);
//   final match = re.firstMatch(StackTrace.current.toString());
//   return (match == null) ? -1 : int.parse(match.namedGroup('line'));
// }

void exampleLogs(Logger logger) {
  print('example print');
  // logger.finest('example finest log entry');
  // logger.finer('example finer log entry');
  // logger.i('example fine log entry');
  // logger.i('example info log entry');
  // logger.w('example warning log entry');
  // logger.e('example severe log entry');
  // logger.shout('example shout log entry');
}

void ansiLogs() {
  // logger.w('\x1b[0m Reset / Normal \x1b[0m');
  // logger.w('\x1b[1m Bold or increased intensity \x1b[0m');
  // logger.w('\x1b[2m Faint (decreased intensity) \x1b[0m');
  // logger.w('\x1b[3m Italic \x1b[0m');
  // logger.w('\x1b[4m Underline \x1b[0m');
  // logger.w('\x1b[5m Slow Blink \x1b[0m');
  // logger.w('\x1b[6m Rapid Blink \x1b[0m');
  // logger.w('\x1b[7m reverse video \x1b[0m');
  // logger.w('\x1b[8m Conceal \x1b[0m');
  // logger.w('\x1b[9m Crossed-out \x1b[0m');
  // logger.w('\x1b[10m Primary(default) font \x1b[0m');
  // logger.w('Alternative Fonts:');
  // logger.w('\t\x1b[11m Alternative font 0\x1b[0m');
  // logger.w('\t\x1b[12m Alternative font 1\x1b[0m');
  // logger.w('\t\x1b[13m Alternative font 2\x1b[0m');
  // logger.w('\t\x1b[14m Alternative font 3\x1b[0m');
  // logger.w('\t\x1b[15m Alternative font 4\x1b[0m');
  // logger.w('\t\x1b[16m Alternative font 5\x1b[0m');
  // logger.w('\t\x1b[17m Alternative font 6\x1b[0m');
  // logger.w('\t\x1b[18m Alternative font 7\x1b[0m');
  // logger.w('\t\x1b[19m Alternative font 8\x1b[0m');
  // logger.w('\x1b[20m Fraktur \x1b[0m');
  // logger.w('\x1b[21m Doubly underline or Bold off \x1b[0m');
  // logger.w('\x1b[22m Normal color or intensity \x1b[0m');
  // logger.w('\x1b[23m Not italic, not Fraktur \x1b[0m');
  // logger.w('\x1b[24m Underline off \x1b[0m');
  // logger.w('\x1b[25m Blink off \x1b[0m');
  // logger.w('\x1b[27m Inverse off \x1b[0m');
  // logger.w('\x1b[28m Reveal \x1b[0m');
  // logger.w('\x1b[29m Not crossed out \x1b[0m');

  // logger.w(' Basic Foreground Colors:');
  // logger.w('\t\x1b[30m Black foreground\x1b[0m');
  // logger.w('\t\x1b[31m Red foreground\x1b[0m');
  // logger.w('\t\x1b[32m Green foreground\x1b[0m');
  // logger.w('\t\x1b[33m Yellow foreground\x1b[0m');
  // logger.w('\t\x1b[34m Blue foreground\x1b[0m');
  // logger.w('\t\x1b[35m Magenta foreground\x1b[0m');
  // logger.w('\t\x1b[36m Cyan foreground\x1b[0m');
  // logger.w('\t\x1b[37m White foreground\x1b[0m');
  // logger.w('\t\x1b[39m Default foreground color \x1b[0m');

  // logger.w(' Basic Background Colors:');
  // logger.w('\t\x1b[40m Black background\x1b[0m');
  // logger.w('\t\x1b[41m Red background\x1b[0m');
  // logger.w('\t\x1b[42m Green background\x1b[0m');
  // logger.w('\t\x1b[43m Yellow background\x1b[0m');
  // logger.w('\t\x1b[44m Blue background\x1b[0m');
  // logger.w('\t\x1b[45m Magenta background\x1b[0m');
  // logger.w('\t\x1b[46m Cyan background\x1b[0m');
  // logger.w('\t\x1b[47m White background\x1b[0m');
  // logger.w('\t\x1b[49m Default background color \x1b[0m');

  // logger.w('\x1b[51m Framed \x1b[0m');
  // logger.w('\x1b[52m Encircled \x1b[0m');
  // logger.w('\x1b[53m Overlined \x1b[0m');
  // logger.w('\x1b[54m Not framed or encircled \x1b[0m');
  // logger.w('\x1b[55m Not overlined \x1b[0m');
  // logger.w('\x1b[60m ideogram underline or right side line \x1b[0m');
  // print(
  //     '\x1b[61m ideogram double underline or double line on the right side \x1b[0m');
  // logger.w('\x1b[62m ideogram overline or left side line \x1b[0m');
  // print(
  //     '\x1b[63m ideogram double overline or double line on the left side \x1b[0m');
  // logger.w('\x1b[64m ideogram stress marking \x1b[0m');
  // logger.w('\x1b[65m ideogram attributes off \x1b[0m');

  // logger.w(' Bright Foreground Colors:');
  // logger.w('\t\x1b[90m Bright Black foreground\x1b[0m');
  // logger.w('\t\x1b[91m Bright Red foreground\x1b[0m');
  // logger.w('\t\x1b[92m Bright Green foreground\x1b[0m');
  // logger.w('\t\x1b[93m Bright Yellow foreground\x1b[0m');
  // logger.w('\t\x1b[94m Bright Blue foreground\x1b[0m');
  // logger.w('\t\x1b[95m Bright Magenta foreground\x1b[0m');
  // logger.w('\t\x1b[96m Bright Cyan foreground\x1b[0m');
  // logger.w('\t\x1b[97m Bright White foreground\x1b[0m');

  // logger.w(' Bright Background Colors:');
  // logger.w('\t\x1b[100m Bright Black background\x1b[0m');
  // logger.w('\t\x1b[101m Bright Red background\x1b[0m');
  // logger.w('\t\x1b[102m Bright Green background\x1b[0m');
  // logger.w('\t\x1b[103m Bright Yellow background\x1b[0m');
  // logger.w('\t\x1b[104m Bright Blue background\x1b[0m');
  // logger.w('\t\x1b[105m Bright Magenta background\x1b[0m');
  // logger.w('\t\x1b[106m Bright Cyan background\x1b[0m');
  // logger.w('\t\x1b[107m Bright White background\x1b[0m');

  // logger.w('\nComplex Colors (8-bit)\n');
  // logger.w('Foreground');
}

BuildContext? globalContext;
bool get isIos =>
    foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
E? firstOrNull<E>(List<E>? list) {
  return list == null || list.isEmpty ? null : list.first;
}

extension DateTimeExtension on DateTime {
  String toTimeString() {
    return DateFormat('H:mm:ss:SSS').format(this);
  }

  String toStringWith(String format) {
    return DateFormat(format).format(this);
  }

  String toShortDateString() {
    return DateFormat("yyyy.MM.dd").format(this);
  }

  String toShortString() {
    return DateFormat("yyyy.MM.dd hh:mm a").format(this);
    // String y = _fourDigits(year);
    // String m = _twoDigits(month);
    // String d = _twoDigits(day);
    // String h = _twoDigits(hour);
    // String min = _twoDigits(minute);
    // String sec = _twoDigits(second);
    // String ms = _threeDigits(millisecond);
    // String us = microsecond == 0 ? "" : _threeDigits(microsecond);
    // if (isUtc) {
    //   return "$y-$m-$d $h:$min:$sec.$ms${us}Z";
    // } else {
    //   return "$y-$m-$d $h:$min:$sec.$ms$us";
    // }
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}
