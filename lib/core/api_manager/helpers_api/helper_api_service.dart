import 'dart:math';

import 'package:http/http.dart' as http;

import '../../strings/enum_manager.dart';
import '../api_url.dart';
import 'log_api.dart';

DateTime? serverDateTime;

const connectionTimeOut = Duration(seconds: 40);

final noInternet = http.Response('No Internet', 481);

final timeOut = http.Response('connectionTimeOut ', 482);

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _rnd = Random();

String getRandomString(int length) =>
    String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

void fixQuery(Map<String, dynamic>? query) {
  query?.removeWhere((key, value) => (value == null || value.toString().isEmpty));

  query?.forEach((key, value) => query[key] = value.toString());
}

Map<String, String> fixFields(Map<String, dynamic>? fields) {
  final mapStringString = <String, String>{};
  fields?.forEach((key, value) {
    mapStringString[key] = value.toString();
  });
  return mapStringString;
}

void fixBody(Map<String, dynamic>? body) {
  body?.removeWhere((key, value) => (value == null || value.toString().isEmpty));
}

void fixPath(String url, String? path) {
  if (path != null) url = '$url/$path';
}

Uri getUri({
  required String url,
  required ApiType type,
  Map<String, dynamic>? query,
  Map<String, dynamic>? body,
  String? path,
  String? hostName,
  String? additional,
}) {
  url = (additional ?? additionalConst) + url;

  fixQuery(query);

  fixBody(body);

  if (path != null) url = '$url/$path';

  final uri = Uri.https(hostName ?? baseUrl, url, query);
  print(uri.toString());
  logRequest(
      type: type,
      url: url,
      q: {}
        ..addAll(query ?? {})
        ..addAll(body ?? {}));
  return uri;
}
