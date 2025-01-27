import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const WeatherDetailItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28.0),
        const SizedBox(height: 5.0),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12.0, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(color: color, fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
