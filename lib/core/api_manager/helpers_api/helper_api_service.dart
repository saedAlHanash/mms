import 'package:http/http.dart' as http;

DateTime? serverDateTime;

const connectionTimeOut = Duration(seconds: 40);

final noInternet = http.Response('No Internet', 481);

final timeOut = http.Response('connectionTimeOut ', 482);