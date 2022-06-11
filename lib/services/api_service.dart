import 'dart:convert';
import 'package:petdoctor/app/app.locator.dart';
import 'package:http/http.dart';

class APIService {
  final Client _client = locator<Client>();

  Future fetchData({required String url, Map<String, dynamic>? params}) async {
    final fetchUrl = Uri.encodeFull(url);
    final headers = {"Accept": "application/json"};

    final response =
        await _client.post(Uri.parse(fetchUrl), headers: headers, body: params);

    if (response.statusCode != 200) {
      throw Exception("Error While Retrieving Data from Url");
    }

    JsonDecoder _decoder = const JsonDecoder();

    return _decoder.convert(response.body);
  }
}
