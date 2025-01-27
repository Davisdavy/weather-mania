
class Weather {
  final String cityName;
  final String description;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final int cloudiness;
  final int visibility;
  final String country;
  final int sunrise;
  final int sunset;
  final String weatherIcon;
  final String main;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.cloudiness,
    required this.visibility,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.weatherIcon,
    required this.main
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDeg: json['wind']['deg'],
      cloudiness: json['clouds']['all'],
      visibility: json['visibility'],
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      weatherIcon: json['weather'][0]['icon'],
      main: json['weather'][0]['main']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'weather': [
        {
          'main': main,
          'description': description,
          'icon': weatherIcon,
        }
      ],
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      },
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
      'clouds': {
        'all': cloudiness,
      },
      'visibility': visibility,
      'sys': {
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      },
    };
  }
}