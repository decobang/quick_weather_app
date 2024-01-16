
// imports required packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// WeatherInfoWidget class that takes in the weather data and displays it
class WeatherInfoWidget extends StatefulWidget {
  final String cityLocation;
  final String temperature;
  final String minTemperature;
  final String maxTemperature;
  final String feelsLike;
  final String weatherData;
  final String wind;
  final String humidity;
  final String sunrise;
  final String sunset;

  const WeatherInfoWidget(
      {super.key,
      required this.cityLocation,
      required this.temperature,
      required this.minTemperature,
      required this.maxTemperature,
      required this.feelsLike,
      required this.weatherData,
      required this.wind,
      required this.humidity,
      required this.sunrise,
      required this.sunset});

  @override
  State<WeatherInfoWidget> createState() => _WeatherInfoWidgetState();
}

class _WeatherInfoWidgetState extends State<WeatherInfoWidget> {
  @override
  Widget build(BuildContext context) {

    // capitalize function to capitalize the first letter of a string
    String capitalize(String s) =>
        s[0].toUpperCase() + s.substring(1).toLowerCase();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(capitalize(widget.cityLocation),
                    style: GoogleFonts.oswald(
                        fontSize: 24, fontWeight: FontWeight.w300)),
                Text('${widget.temperature}°F',
                    style: GoogleFonts.oswald(
                      fontSize: 56,
                      fontWeight: FontWeight.w500,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Low \n ${widget.minTemperature}°F',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        )),
                    const SizedBox(width: 12),
                    Text('High \n ${widget.maxTemperature}°F',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        )),
                    const SizedBox(width: 12),
                    Text('Feels Like \n ${widget.feelsLike}°F',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(capitalize(widget.weatherData),
                    style: GoogleFonts.oswald(
                        fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Sunrise \n ${widget.sunrise}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        )),
                    const SizedBox(width: 12),
                    Text('Sunset \n ${widget.sunset}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Wind | mph \n',
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.wind,
                            style: GoogleFonts.oswald(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Humidity \n',
                        style: GoogleFonts.oswald(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${widget.humidity}%',
                            style: GoogleFonts.oswald(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
