import '../widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Explore',
                        style: GoogleFonts.elsieSwashCaps(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    Text('.',
                        style: GoogleFonts.elsieSwashCaps(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.orange)),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Icon(Icons.wb_sunny_outlined)
                        : Icon(Icons.nightlight_outlined)),
              ],
            ),
            SearchBar(),
          ]),
    );
  }
}
