// print('\x1B[30m dsfkjasd \x1B[0m');
// print(' \x1B[31m dsfkjasd \x1B[0m');
// print(' \x1B[32m dsfkjasd \x1B[0m');
// print(' \x1B[33m dsfkjasd \x1B[0m');
// print(' \x1B[34m dsfkjasd \x1B[0m');
// print(' \x1B[35m dsfkjasd \x1B[0m');
// print(' \x1B[36m dsfkjasd \x1B[0m');
// print(' \x1B[37m dsfkjasd \x1B[0m');
// print(' \x1B[0m dsfkjasd \x1B[0m');
//
// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m

import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';
import '../api_service.dart';

void saedsaed() {
  var loggerObjectApi = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      // number of method calls to be displayed
      errorMethodCount: 0,
      // number of method calls if stacktrace is provided
      lineLength: 300,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: false,
      // Print an emoji for each log message
      printTime: false,
      levelColors: {
        Level.trace: AnsiColor.fg(40),
        Level.debug: AnsiColor.fg(1),
        Level.info: AnsiColor.fg(2),
        Level.warning: AnsiColor.fg(3),
        Level.error: AnsiColor.fg(4),
      },
    ),
  );

  loggerObjectApi.log(Level.trace, Level.trace.name);
  loggerObjectApi.log(Level.debug, Level.debug.name);
  loggerObjectApi.log(Level.info, Level.info.name);
  loggerObjectApi.log(Level.warning, Level.warning.name);
  loggerObjectApi.log(Level.error, Level.error.name);
}

String coloring(String url, ApiType type) {
  switch (type) {
    case ApiType.get:
      return '\x1B[34m $url \x1B[0m';
    case ApiType.post:
      return '\x1B[32m $url \x1B[0m';
    case ApiType.put:
      return '\x1B[33m $url \x1B[0m';
    case ApiType.patch:
      return '\x1B[36m $url \x1B[0m';
    case ApiType.delete:
      return '\x1B[31m $url \x1B[0m';
  }
}

void logRequest({
  required String url,
  Map<String, dynamic>? q,
  String? additional,
  required ApiType type,
}) {
  var msg = coloring(url, type);

  if (q != null) msg += '\n ${jsonEncode(q)}';
  if (additional != null) msg += '\n $additional';

  loggerObject.i(msg);
}

void logResponse({
  required String url,
  required Response response,
  required ApiType type,
}) {
  var r = [];
  var res = '';
  if (response.body.length > 800) {
    r = response.body.splitByLength1(800);
    for (var e in r) {
      res += '$e\n';
    }
  } else {
    res = response.body;
  }

  loggerObject.t('${coloring(url, type)} [${response.statusCode}] \n $res');
}
