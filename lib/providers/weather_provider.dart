
import 'package:flutter/material.dart';
import 'package:weathermania/models/forecast_model.dart';
import 'package:weathermania/models/weather_model.dart';
import 'package:weathermania/services/local_storage_service.dart';
import 'package:weathermania/services/weather_service.dart';


class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;
  List<Forecast>? _forecast;
  bool _isLoading = false;
  bool _isSearchBarVisible = false;
  String? _lastUpdated;
  String? _errorMessage;

  Weather? get currentWeather => _currentWeather;
  List<Forecast>? get forecast => _forecast;
  bool get isLoading => _isLoading;
  bool get isSearchBarVisible => _isSearchBarVisible;
  String? get lastUpdated => _lastUpdated;
  String? get errorMessage => _errorMessage;

  final WeatherService _weatherService = WeatherService();
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.fetchCurrentWeather(city);
      _forecast = await _weatherService.fetchForecast(city);
      await _localStorageService.saveWeatherData(_currentWeather!, _forecast!);
      _lastUpdated = await _localStorageService.getLastUpdated();
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching weather data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleSearchBarVisibility() {
    _isSearchBarVisible = !_isSearchBarVisible;
    notifyListeners();
  }

  Future<void> loadCachedData() async {
    _currentWeather = await _localStorageService.getWeatherData();
    _forecast = await _localStorageService.getForecastData();
    _lastUpdated = await _localStorageService.getLastUpdated();
    notifyListeners();
  }
}