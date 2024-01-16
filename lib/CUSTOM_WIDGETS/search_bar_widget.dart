// imports required packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget that allows the user to search for a city
class SearchBarWidget extends StatefulWidget {
  final Function fetchWeatherCallback;

  const SearchBarWidget({super.key, required this.fetchWeatherCallback});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  // use a TextEditingController to get the text from the search bar and validate input
  final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText: "enter a city",
                    labelStyle: GoogleFonts.oswald(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: cityController,

                  // checks the input for valid characters
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    } else if (!RegExp(r'^[a-zA-Z\s]*$').hasMatch(value)) {
                      return 'Please enter a valid city name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        widget.fetchWeatherCallback(value);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (cityController.text.isNotEmpty) {
                    setState(() {
                      widget.fetchWeatherCallback(cityController.text);
                    });
                  }
                },
                child: Text(
                  'Search',
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
