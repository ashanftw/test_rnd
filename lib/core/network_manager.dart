import 'dart:convert';
import 'package:http/http.dart' as http;

enum HttpMethod { post, get, put, delete }

class NetworkManager {
  Map<String, String> headers = {'content-type': 'application/json'};

  Future<dynamic> sendRequest(
      {HttpMethod type = HttpMethod.get,
      required String path,
      dynamic body}) async {
    try {
      Uri url = Uri.parse(path);

      dynamic response;
      switch (type) {
        case HttpMethod.get:
          response = await http.get(url, headers: headers);
          break;
        case HttpMethod.post:
          response = await http.post(url, body: body, headers: headers);
          break;
        case HttpMethod.put:
          response = await http.put(url, body: body, headers: headers);
          break;
        case HttpMethod.delete:
          response = await http.delete(url, body: body, headers: headers);
          break;
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception('request failed');
    } catch (e) {
      throw Exception(e);
    }
  }
}
