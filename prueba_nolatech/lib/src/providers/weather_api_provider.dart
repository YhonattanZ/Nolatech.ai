import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/models/weather.dart';
import 'package:prueba_nolatech/src/providers/custom_http_provider.dart';

class WeatherApiProvider extends ChangeNotifier {
  final apiKey = '15b0485bb7e775f383e83a1b07ef31fa';

  Future<Weathers> fetchWeather() async {
    const city = 'Caracas';
    const url = 'https://api.openweathermap.org/data/2.5';
    final endpoint = '/weather?q=$city&appid=$apiKey';
    final http = CustomHttpProvider(baseUrl: url);
    final response = await http.get(endpoint);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    print(responseBody);
    return Weathers.fromJson(responseBody);
  }
}
