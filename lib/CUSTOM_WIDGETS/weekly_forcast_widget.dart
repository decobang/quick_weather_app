// import required packages
import 'dart:convert';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// WeeklyForcastWidget class that takes in the weather data and displays it
class WeeklyForcastWidget extends StatefulWidget {
  
  // initialize variables
  final String cityLocation;
  final String userApiKey;

  const WeeklyForcastWidget(
      {super.key, required this.userApiKey, required this.cityLocation});

  @override
  State<WeeklyForcastWidget> createState() => _WeeklyForcastWidgetState();
}

class _WeeklyForcastWidgetState extends State<WeeklyForcastWidget> {
  Future<List<Map<String, dynamic>>> fetchForecast(
      String apiKey, String city) async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['list']);
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchForecast(widget.userApiKey, widget.cityLocation),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var dailyData = <Map<String, dynamic>>[];

          for (var i = 0; i < snapshot.data!.length; i++) {
            var forecast = snapshot.data![i];
            var dateTime =
                DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);

            if (i == 0 ||
                dateTime.day !=
                    DateTime.fromMillisecondsSinceEpoch(
                            snapshot.data![i - 1]['dt'] * 1000)
                        .day) {
              dailyData.add(forecast);
            }
          }

          return Card(
            elevation: 10,
            shadowColor: Colors.black,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: min(7, dailyData.length),
              itemBuilder: (context, index) {
                var forecast = dailyData[index];
                var dateTime =
                    DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
                var temperature = 1.8 * (forecast['main']['temp'] - 273) + 32;

                var daysOfWeek = [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ];
                var dayOfWeek = daysOfWeek[dateTime.weekday - 1];

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 50),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(dayOfWeek,
                                    style: GoogleFonts.oswald(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    )),
                                Text('${temperature.toStringAsFixed(0)}°F',
                                    style: GoogleFonts.oswald(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Min\n${(1.8 * (forecast['main']['temp_min'] - 273) + 32).toStringAsFixed(0)}°F',
                                  style: GoogleFonts.oswald(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Text(
                                  'Max\n${(1.8 * (forecast['main']['temp_max'] - 273) + 32).toStringAsFixed(0)}°F',
                                  style: GoogleFonts.oswald(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
