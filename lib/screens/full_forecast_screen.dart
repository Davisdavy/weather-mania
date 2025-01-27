import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weathermania/providers/theme_provider.dart';
import 'package:weathermania/providers/weather_provider.dart';

class FullForecastScreen extends StatelessWidget {
  final String cityName;

  const FullForecastScreen({Key? key, required this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final forecastList = weatherProvider.forecast;

    final backgroundColor = themeProvider.isDarkMode ? Colors.black : Colors.white;
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(" $cityName"),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      backgroundColor: backgroundColor,
      body: ListView.builder(
        itemCount: forecastList?.length ?? 0,
        itemBuilder: (context, index) {
          final forecast = forecastList![index];
          final dateFormat = DateFormat('MMM d, h a');
          return ListTile(
            leading: Image.network(
              'http://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png',
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace){
                return HugeIcon(
                  icon: HugeIcons.strokeRoundedAiCloud,
                  color: textColor,
                  size: 45.0,
                );
              },
            ),
            title: Text(
              "${forecast.temperature.toStringAsFixed(1)}°",
              style: TextStyle(color: textColor),
            ),
            subtitle: Text(
              forecast.weatherDescription,
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
            trailing: Text(
              dateFormat.format(forecast.date),
              style: TextStyle(color: textColor),
            ),
          );
        },
      ),
    );
  }
}

