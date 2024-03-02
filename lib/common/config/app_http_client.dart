import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppHttpService {
  String baseUrl = 'http://api.openweathermap.org/data/2.5/forecast';
  String apiKey = 'e1e233b23676eeb955c067ff66d75e6a';

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint&appid=$apiKey&units=metric'));
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    final statusCode = response.statusCode;
    final responseBody = jsonDecode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody;
    }

    throw Exception('ERROR: $statusCode - ${responseBody['error']}');
  }
}
