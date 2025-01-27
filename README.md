# Weather Mania

A mobile application built with Flutter that fetches and displays weather data from the OpenWeather API. The app provides the current weather and a 5-day forecast for any city, with a clean and modern user interface. It also supports offline storage to display cached data when the app is offline.

## Features
1. Current Weather: Displays the current weather conditions for a selected city.

2. 5-Day Forecast: Shows a detailed 5-day weather forecast.

3. City Search: Allows users to search for a city and view its weather details.

4. Offline Support: Caches weather data locally and displays it when the app is offline.

5. Error Handling: Gracefully handles network issues, API errors, and invalid city searches.

## Installation
- Flutter SDK: Ensure you have Flutter installed. If not, follow the official Flutter installation [guide](https://docs.flutter.dev/get-started/install).

- OpenWeather API Key: Use the provided API key (cfe577b09f43deea2722462eea76e473) or replace it with your own in the .env file.

- Dart SDK: Comes bundled with Flutter.

- IDE: Android Studio, VS Code, or any other IDE with Flutter support.

## Setup Instructions
### 1. Clone the Repository
Clone the repository to your local machine:


```
git clone https://github.com/your-username/weather-app.git
cd weather-app
```

### 2. Add API Key
add your OpenWeather API key in the .env file:
``` 
OPEN_WEATHER_API_KEY= YOUR_API_KEY_HERE
```
### 3. Install Dependencies
```
flutter pub get
```
#### 4. Run the App
```
flutter run
```
## Project Structure
```
weather-app/
├── lib/
│   ├── models/              # Data models (e.g., Weather, Forecast)
│   ├── services/            # API service and data fetching logic
│   ├── providers/           # State management (e.g., WeatherProvider)
│   ├── screens/             # UI screens (e.g., WeatherScreen)
│   ├── widgets/             # Reusable UI components
│   ├── main.dart            # Entry point of the app
├── assets/                  # Static assets (e.g., fonts, images)
├── .env                     # Environment variables (API key)
├── pubspec.yaml             # Project dependencies and metadata
```
### API Integration
The app uses the following OpenWeather API endpoints:

- `Current Weather`: http://api.openweathermap.org/data/2.5/weather?q={city}&appid={apiKey}&units=metric

- `5-Day Forecast` : http://api.openweathermap.org/data/2.5/forecast?q={city}&appid={apiKey}&units=metric

The API key is stored securely in the .env file and accessed using the flutter_dotenv package.

### Offline Support
The app uses local caching `sharedpreferences`to store weather data. When the app is offline, it displays the last fetched weather data and indicates the last update time.

### Error Handling
The app gracefully handles the following errors:

- **No Internet Connection**: Displays a user-friendly message and allows retrying.

- **City Not Found**: Informs the user that the city is invalid and prompts them to try another city.

- **API Errors**: Shows a generic error message for server-related issues.

## Screenshots
![Weather  Page](/assets/images/city_weather.jpeg "Weather Page")
![Search City](/assets/images/city_seach.jpeg "Search City")
![City Forecast](/assets/images/city_forecast.jpeg "City Forecast")

### Challenges and Solutions
#### Challenges Faced
- `Handling API Errors`: Ensuring the app doesn’t crash when the API returns an error.

- `Offline Support`: Implementing local caching and displaying cached data when offline.

- `UI Responsiveness`: Making the app look good on different screen sizes.

#### Solutions Implemented
- `Error Handling`: Used `try-catch` blocks and specific error messages for different scenarios.

- `Local Caching`: Used `SharedPreferences` to store weather data locally.

- `Responsive Design`: Used Flutter’s flexible layout widgets like `Flexible`, `Expanded`, and `MediaQuery`

### Future Improvements
1. Add support for location-based weather using GPS.

2. Support multiple cities and allow users to save their favorite locations.
## License

[MIT](https://choosealicense.com/licenses/mit/)

### Acknowledgments
**OpenWeather**: For providing the weather data API.

**Flutter Community**: For the amazing packages and resource