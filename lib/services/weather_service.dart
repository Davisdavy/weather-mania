
import 'dart:convert';

import 'package:weathermania/models/forecast_model.dart';
import 'package:weathermania/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'f141d46ca55c3c286d68a00b38a94856';
  final String baseUrl = 'http://api.openweathermap.org/data/2.5/';

  Future<Weather> fetchCurrentWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Forecast>> fetchForecast(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body)['list'];
      return jsonList.map((json) => Forecast.fromJson(json)).toList();
    } else if(response.statusCode == 404) {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message']);
    }
    else {
      throw Exception('Failed to load forecast data');
    }
  }
}