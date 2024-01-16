
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

import 'package:quick_weather_app/CUSTOM_WIDGETS/search_bar_widget.dart';
import 'package:quick_weather_app/CUSTOM_WIDGETS/weather_info_widget.dart';
import 'package:quick_weather_app/CUSTOM_WIDGETS/weekly_forcast_widget.dart';


class WeatherAppImproved extends StatefulWidget {
  const WeatherAppImproved({super.key});

  @override
  State<WeatherAppImproved> createState() => _WeatherAppImprovedState();
}

class _WeatherAppImprovedState extends State<WeatherAppImproved> {
  
  String apiKey = ""; // Add your API key here from OpenWeatherMap.org

  // initialize variables 
  String weatherData = "Loading...";
  String city = "Brentwood";
  late String wind = '';
  late String humidity = '';
  late String precipitation = '';
  late String sunrise = '';
  late String sunset = '';

  late String temperature = '';
  late String minTemperature = '';
  late String maxTemperature = '';
  late String feelsLike = '';

  late String moonPhase = '';
  late String uvIndex = '';
  late String visibility = '';
  late String airQuality = '';
  late String forecast = '';

  // initialize the state and call the fetchWeather function
  @override
  void initState() {
    super.initState();
    fetchWeather(city);
  }

  // dispose of the state when the app is closed
  @override
  void dispose() {
    super.dispose();
  }

// fetchWeather function that takes in a city and returns the weather data
  fetchWeather(String city) async {

    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));

    // decode the json data and parse it into the variables
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        if (data['weather'] is List &&
            data['weather'].isNotEmpty &&
            data['weather'][0]['description'] is String) {
          weatherData = data['weather'][0]['description'];
        } else if (response.statusCode == 404) {
          setState(() {
            weatherData = "City not found";
          });
        } else {
          weatherData = "Loading...";
        }

        // convert the temperature from Kelvin to Fahrenheit
        var tempInKelvin = data['main']['temp'];
        var tempInFahrenheit = 1.8 * (tempInKelvin - 273) + 32;
        var tempMinInKelvin = data['main']['temp_min'];
        var tempMinInFahrenheit = 1.8 * (tempMinInKelvin - 273) + 32;
        var tempMaxInKelvin = data['main']['temp_max'];
        var tempMaxInFahrenheit = 1.8 * (tempMaxInKelvin - 273) + 32;
        var feelsLikeInKelvin = data['main']['feels_like'];
        var feelsLikeInFahrenheit = 1.8 * (feelsLikeInKelvin - 273) + 32;

        temperature = tempInFahrenheit.toStringAsFixed(0);
        feelsLike = feelsLikeInFahrenheit.toStringAsFixed(0);
        minTemperature = tempMinInFahrenheit.toStringAsFixed(0);
        maxTemperature = tempMaxInFahrenheit.toStringAsFixed(0);

        wind = data['wind']['speed'].toString();
        humidity = data['main']['humidity'].toString();

        // convert the sunrise and sunset times from milliseconds to a readable format
        sunrise =
            DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000)
                .toString();
        sunset =
            DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000)
                .toString();

        var sunriseDateTime =
            DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000);
        var sunsetDateTime =
            DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000);
        var timeFormat =
            DateFormat.jm(); // jm stands for Hour:Minute with AM/PM
        sunrise = timeFormat.format(sunriseDateTime);
        sunset = timeFormat.format(sunsetDateTime);
      });
    }
  }

  // updateCity function that takes in a new city and updates the state
  void updateCity(String newCity) {
    setState(() {
      city = newCity;
      fetchWeather(city);
    });
  }


  // build function that builds the app and returns the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            color: Colors.white,
            child: SizedBox(
              width: 850,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchBarWidget(fetchWeatherCallback: updateCity), // calls the SearchBarWidget
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: 415,

                            // calls the WeatherInfoWidget and passes in the arguments
                            child: WeatherInfoWidget(
                                cityLocation: city,
                                temperature: temperature,
                                minTemperature: minTemperature,
                                maxTemperature: maxTemperature,
                                feelsLike: feelsLike,
                                wind: wind,
                                humidity: humidity,
                                sunrise: sunrise,
                                sunset: sunset,
                                weatherData: weatherData),
                          ),
                          SizedBox(
                            width: 415,
                            child: WeeklyForcastWidget(
                                userApiKey: apiKey, cityLocation: city),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Weather data provided by OpenWeatherMap',
                            style: GoogleFonts.oswald(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' | Assisted by GitHub Copilot |',
                                style: GoogleFonts.oswald(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' Made with ❤️ by David Coggin',
                                style: GoogleFonts.oswald(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
