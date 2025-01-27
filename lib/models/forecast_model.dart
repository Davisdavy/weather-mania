
class Forecast {
  final DateTime date;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final int windDeg;
  final int cloudiness;
  final int visibility;
  final double pop;
  final double? rainVolume;

  Forecast({
    required this.date,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.windDeg,
    required this.cloudiness,
    required this.visibility,
    required this.pop,
    this.rainVolume,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDeg: json['wind']['deg'],
      cloudiness: json['clouds']['all'],
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      rainVolume: json['rain']?['3h']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': date.toIso8601String(),
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      },
      'weather': [
        {
          'description': weatherDescription,
          'icon': weatherIcon,
        }
      ],
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
      'clouds': {
        'all': cloudiness,
      },
      'visibility': visibility,
      'pop': pop,
      'rain': rainVolume != null ? {'3h': rainVolume} : null,
    };
  }
}