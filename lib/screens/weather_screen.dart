import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:weathermania/providers/location_handler.dart';
import 'package:weathermania/providers/theme_provider.dart';
import 'package:weathermania/providers/weather_provider.dart';
import 'package:weathermania/screens/full_forecast_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:weathermania/widgets/drawer_widget.dart';
import 'package:weathermania/widgets/forecast_list_widget.dart';
import 'package:weathermania/widgets/weather_detail_widget.dart';
import 'package:weathermania/widgets/weather_shimmer_loading.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  bool isDaytime(DateTime sunrise, DateTime sunset) {
    final now = DateTime.now();
    return now.isAfter(sunrise) && now.isBefore(sunset);
  }

  String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  Future<void> _loadData() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProvider.loadCachedData();
    await _fetchCurrentCityWeather();
  }

  Future<void> _fetchCurrentCityWeather() async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    String currentCity = await _getCurrentCity();
    try {
      await weatherProvider.fetchWeather(currentCity);
    } catch (e) {
      if (weatherProvider.currentWeather == null) {
        _showErrorDialog(
          context,
          "Failed to fetch data. Showing cached data.",
              () {
            _fetchCurrentCityWeather();
          },
        );
      }
    }
  }

  Future<String> _getCurrentCity() async {
    Position? position = await LocationHandler.getCurrentPosition();
    String? city = await LocationHandler.getCityFromLatLong(position!);

    return city ?? "Nairobi"; // Default to Nairobi if city retrieval fails
  }

  void _showErrorDialog(BuildContext context, String errorMessage, VoidCallback onRetry) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: Text("Retry"),
            ),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, WeatherProvider weatherProvider, Color textColor, ThemeProvider themeProvider) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: weatherProvider.isSearchBarVisible ? 120 : 90,
      elevation: 0.0,
      leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: HugeIcon(icon: HugeIcons.strokeRoundedMenu02, color: textColor));
          }
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    weatherProvider.toggleSearchBarVisibility();
                  },
                  child: SizedBox(
                    width: 200.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: textColor,
                          size: 22.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              weatherProvider.currentWeather?.cityName ?? 'Loading...',
                              style: TextStyle(color: textColor,fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                weatherProvider.isSearchBarVisible ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                color: textColor,
                                size: 18.0,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                weatherProvider.isSearchBarVisible
                    ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width / 2.0,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textColor.withOpacity(0.3),
                        hintText: "Search city",
                        hintStyle: TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onSubmitted: (value) async {
                        await weatherProvider.fetchWeather(value);
                        weatherProvider.toggleSearchBarVisibility();

                        if (weatherProvider.errorMessage != null && context.mounted) {
                          _showErrorDialog(
                            context,
                            weatherProvider.errorMessage!,
                                () {
                              weatherProvider.fetchWeather(value);
                            },
                          );
                        }
                      },
                    ),
                  ),
                )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              width: 50.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: FullForecastScreen(cityName: weatherProvider.currentWeather!.cityName),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Icon(
                Icons.calendar_today,
                color: textColor,
                size: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);

    final lastUpdated = weatherProvider.lastUpdated;
    final lastUpdatedString = lastUpdated != null
        ? timeago.format(DateTime.parse(lastUpdated))
        : 'Never';

    final currentWeather = weatherProvider.currentWeather;
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(
        currentWeather != null ?
        weatherProvider.currentWeather!.sunrise * 1000 : 0000);
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(
        currentWeather != null ?
        weatherProvider.currentWeather!.sunset * 1000 : 0000);

    final isDay = isDaytime(sunriseTime, sunsetTime);
    final nextEventTime = isDay ? sunsetTime : sunriseTime;
    final nextEventLabel = isDay ? 'SUNSET' : 'SUNRISE';

    final backgroundColor = themeProvider.isDarkMode ? Colors.black : Colors.white;
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawerEnableOpenDragGesture: false,
      appBar: _buildAppBar(context, weatherProvider, textColor, themeProvider),
      drawer: DrawerWidget(themeProvider),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: backgroundColor, // Use theme-based background color
          child: SafeArea(
            child: weatherProvider.isLoading ?  WeatherShimmerLoading() : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180.0,
                      width: 180.0,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: weatherProvider.currentWeather?.weatherIcon != null
                            ? 'http://openweathermap.org/img/wn/${weatherProvider.currentWeather?.weatherIcon}@2x.png'
                            : 'https://fakeimg.pl/600x400',
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return HugeIcon(
                            icon: HugeIcons.strokeRoundedAiCloud,
                            color: textColor,
                            size: 180.0,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      weatherProvider.currentWeather?.description ?? 'Loading...',
                      style: TextStyle(color: textColor, fontSize: 20),
                    ),
                    Text(
                      '${weatherProvider.currentWeather?.temperature ?? 0}°',
                      style: TextStyle(color: textColor, fontSize: 40),
                    ),
                    const SizedBox(height: 10.0),
                    WeatherDetailsWidget(weatherProvider, textColor, nextEventTime, nextEventLabel),
                    const SizedBox(height: 20.0),
                    ForecastListWidget(weatherProvider, textColor),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Updated: $lastUpdatedString",
                      style: TextStyle(color: textColor, fontSize: 9.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
