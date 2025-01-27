

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathermania/models/forecast_model.dart';
import 'package:weathermania/models/weather_model.dart';


class LocalStorageService {
  static const String _weatherKey = 'weather';
  static const String _forecastKey = 'forecast';
  static const String _lastUpdatedKey = 'lastUpdated';

  Future<void> saveWeatherData(Weather weather, List<Forecast> forecast) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_weatherKey, json.encode(weather.toJson()));
    prefs.setString(_forecastKey, json.encode(forecast.map((f) => f.toJson()).toList()));
    prefs.setString(_lastUpdatedKey, DateTime.now().toString());
  }

  Future<Weather?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherJson = prefs.getString(_weatherKey);
    if (weatherJson != null) {
      return Weather.fromJson(json.decode(weatherJson));
    }
    return null;
  }

  Future<List<Forecast>?> getForecastData() async {
    final prefs = await SharedPreferences.getInstance();
    final forecastJson = prefs.getString(_forecastKey);
    if (forecastJson != null) {
      List<dynamic> jsonList = json.decode(forecastJson);
      return jsonList.map((json) => Forecast.fromJson(json)).toList();
    }
    return null;
  }

  Future<String?> getLastUpdated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastUpdatedKey);
  }
}