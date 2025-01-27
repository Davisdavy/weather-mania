
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weathermania/models/forecast_model.dart';
import 'package:weathermania/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
  final String baseUrl = 'http://api.openweathermap.org/data/2.5/';

  Future<Weather> fetchCurrentWeather(String city) async {
    try {
      final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
      final url = '$baseUrl/weather?q=$city&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return Weather.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        final errorData = json.decode(response.body);
        throw 'City not found: ${errorData['message']}';

      } else {
        throw 'Failed to fetch weather data. Status code: ${response.statusCode}';
      }
    } on SocketException catch (_) {
      throw 'No internet connection. Please check your network settings.';
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<List<Forecast>> fetchForecast(String city) async {
    try {
      final url = '$baseUrl/forecast?q=$city&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body)['list'];
        return jsonList.map((json) => Forecast.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        final errorData = json.decode(response.body);
        throw 'City not found: ${errorData['message']}';
      } else {
        throw 'Failed to fetch forecast data. Status code: ${response.statusCode}';
      }
    } on SocketException catch (_) {
      throw 'No internet connection. Please check your network settings.';
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }
}