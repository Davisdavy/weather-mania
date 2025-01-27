
import 'package:flutter/material.dart';
import 'package:weathermania/providers/theme_provider.dart';

Widget DrawerWidget(ThemeProvider themeProvider) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.blueGrey,
          ),
          child: Text(
            'Weather Mania',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: Text(themeProvider.isDarkMode ? 'Dark mode' : 'Light mode'),
          trailing: Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
          ),
        ),
        // Add more menu items here if needed
      ],
    ),
  );
}