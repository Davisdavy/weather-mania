
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:weathermania/providers/weather_provider.dart';
import 'package:weathermania/widgets/weather_detail_item.dart';

Widget WeatherDetailsWidget(WeatherProvider weatherProvider, Color textColor, DateTime nextEventTime, String nextEventLabel) {
  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  return SizedBox(
    height: 100.0,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WeatherDetailItem(
            icon: HugeIcons.strokeRoundedSun01,
            label: nextEventLabel,
            value: formatTime(nextEventTime),
            color: textColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: VerticalDivider(color: textColor, ),
          ),
          WeatherDetailItem(
            icon: HugeIcons.strokeRoundedSlowWinds,
            label: 'WIND',
            value: '${weatherProvider.currentWeather?.windSpeed ?? 0} km/h',
            color: textColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: VerticalDivider(color: textColor, ),
          ),
          WeatherDetailItem(
            icon: HugeIcons.strokeRoundedThermometerWarm,
            label: 'TEMPERATURE',
            value: '${weatherProvider.currentWeather?.tempMax ?? 0}° | ${weatherProvider.currentWeather?.tempMin ?? 0}°',
            color: textColor,
          ),
        ],
      ),
    ),
  );
}