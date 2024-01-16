// Author: David Coggin
// Made with Github Copilot

import 'package:flutter/material.dart';
import 'package:quick_weather_app/weather_app.dart';
void main() {
  runApp(MaterialApp(
    title: 'Quick Weather',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const WeatherAppImproved(), // calls the WeatherAppImproved widget
    debugShowCheckedModeBanner: false,
  ));
}
