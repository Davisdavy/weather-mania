import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathermania/providers/theme_provider.dart';
import 'package:weathermania/providers/weather_provider.dart';
import 'package:weathermania/screens/weather_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
    ],
    child:
      const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Weather Mania',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: WeatherScreen(),
    );
  }
}


