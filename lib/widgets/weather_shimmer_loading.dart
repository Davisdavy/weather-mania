
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weathermania/providers/theme_provider.dart';

class WeatherShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final backgroundColor = themeProvider.isDarkMode ? Colors.grey[900]! : Colors.grey[300]!;
    final shimmerBaseColor = themeProvider.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
    final shimmerHighlightColor = themeProvider.isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 150,
            height: 20,
            color: backgroundColor,
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            height: 40,
            color: backgroundColor,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 20,
                color: backgroundColor,
              ),
              SizedBox(width: 20),
              Container(
                width: 80,
                height: 20,
                color: backgroundColor,
              ),
            ],
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}