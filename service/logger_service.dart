import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    AnsiColor? color = PrettyPrinter.levelColors[event.level];
    String? emoji = PrettyPrinter.levelEmojis[event.level];
    return [color!('$emoji [$className]: ${event.message}')];
  }
}

void printLog({
  String? className,
  required String message,
  String logType = "e",
}) {
  final log = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );
  if (kDebugMode) {
    switch (logType) {
      case "v":
        return log.v("[$className]: $message");
      case "d":
        return log.d("[$className]: $message");
      case "i":
        return log.i("[$className]: $message");
      case "w":
        return log.w("[$className]: $message");
      case "e":
        return log.e("[$className]: $message");
    }
  }
}
