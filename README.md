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

- OpenWeather API Key: Provided by creating an account in openweather

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
<table>
  <tr>
    <td>Weather Screen</td>
     <td>City Search Screen</td>
     <td>City Forecast Screen</td>
  </tr>
  <tr>
    <td><img src="/assets/images/city_weather.jpeg" width=270 height=480></td>
    <td><img src="/assets/images/city_search.jpeg" width=270 height=480></td>
    <td><img src="/assets/images/city_forecast.jpeg" width=270 height=480></td>
  </tr>
 </table>


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

## Contributing
We welcome contributions from the community! Whether you're fixing a bug, improving documentation, or adding a new feature, your help is appreciated. Here's how you can contribute:

#### Branching Strategy
`main` branch: This branch contains the stable, production-ready code. Direct commits to this branch are restricted.It is also the default branch. All contributions should be made by creating a feature branch from `main` and submitting a pull request (PR) to merge back into it.

#### Steps to Contribute
**1. Fork the Repository:** Click the "Fork" button on the top right of the repository page to create your own copy.

**2. Clone the Repository:**
```
git clone https://github.com/your-username/weather-app.git
cd weather-app
```
**3. Create a Feature Branch:**
Create a new branch from the `develop` branch for your changes:

```
git checkout develop
git checkout -b feature/your-feature-name
```
**4. Make Your Changes:**

* Write your code and ensure it follows the project's coding standards.
* Add tests if applicable.
* Update documentation if needed.

**5. Commit Your Changes:**
Commit your changes with a clear and descriptive commit message:

```
git commit -m "Add: [Your feature description]"
```
**6. Push Your Changes:**
Push your branch to your forked repository:

```
git push origin feature/your-feature-name
```
**7. Create a Pull Request (PR):**
* Go to the original repository on GitHub.
* Click on the "Pull Requests" tab and then "New Pull Request."
* Select develop as the base branch and your feature branch as the compare branch.
* Provide a clear title and description for your PR, explaining the changes and their purpose.

**8. Code Review:**
* Your PR will be reviewed by maintainers. They may suggest changes or improvements.
* Once approved, your changes will be merged into the develop branch.

**9. Critical Fixes:**
* For critical bug fixes or security patches, create a PR directly to the main branch. Ensure the PR is clearly labeled as a critical fix.

#### Code Guidelines
* Follow the existing code style and structure.
* Write clear and concise commit messages.
* Ensure your code is well-documented and includes comments where necessary.
* Add or update tests for any new functionality or bug fixes.

#### Reporting Issues
If you find a bug or have a feature request, please open an issue on GitHub. Provide as much detail as possible, including steps to reproduce the issue or a description of the feature.

#### Code of Conduct
Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project, you agree to abide by its terms.

## License

[MIT](https://choosealicense.com/licenses/mit/)

### Acknowledgments
**OpenWeather**: For providing the weather data API.

**Flutter Community**: For the amazing packages and resource