import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathermania/providers/weather_provider.dart';

Widget ForecastListWidget(WeatherProvider weatherProvider, Color textColor) {
  return SizedBox(
    height: 180,
    child: ListView.builder(
      itemCount: weatherProvider.forecast?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int index) {
        final forecast = weatherProvider.forecast![index];
        final dateFormat = DateFormat('MMM d');
        final timeFormat = DateFormat('h a');
        return SizedBox(
          height: 150.0,
          width: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormat.format(forecast.date),
                style: TextStyle(color: textColor),
              ),
              Container(
                height: 130.0,
                width: 90.0,
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        timeFormat.format(forecast.date),
                        style: TextStyle(color: textColor),
                      ),
                      Image.network(
                        'http://openweathermap.org/img/wn/${forecast.weatherIcon}@2x.png',
                        width: 50.0,
                        height: 50.0,
                      ),
                      Text(
                        '${forecast.temperature.toStringAsFixed(1)}°',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
