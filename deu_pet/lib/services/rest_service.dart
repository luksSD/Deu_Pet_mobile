import 'dart:convert';

import 'package:http/http.dart' as http;

class RestService {
  static Future<int?> post(String url, dynamic body) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: body, headers: {"Content-type": "application/json"});

      if (response.statusCode == 200) {
        return int.parse(response.body);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> get(String url, dynamic body) async {
    try {
      var response = await http
          .get(Uri.parse(url), headers: {"Content-type": "application/json"});

      if (response.statusCode == 200) {
        return (utf8.decode(response.bodyBytes));
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
