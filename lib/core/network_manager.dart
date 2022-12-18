import 'dart:convert';
import 'package:http/http.dart';

enum HttpMethod { post, get, put, delete }

class NetworkManager {
  late Client client;
  NetworkManager({required this.client});

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
          response = await client.get(url, headers: headers);
          break;
        case HttpMethod.post:
          response = await client.post(url, body: body, headers: headers);
          break;
        case HttpMethod.put:
          response = await client.put(url, body: body, headers: headers);
          break;
        case HttpMethod.delete:
          response = await client.delete(url, body: body, headers: headers);
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
