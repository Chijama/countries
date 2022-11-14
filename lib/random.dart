import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/screens/details_screen.dart';
import 'package:untitled/widgets/languages.dart';

import '/service.dart';

import '../models/country_model.dart';

import '../widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late Future<List<CountriesModel>> countriesData;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    countriesData = Service().getCountries();
  }

  String searchParameter = "";
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder<List<CountriesModel>>(
          future: countriesData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text("List is empty");
              }
              return Column(
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
                    SizedBox(
                      height: 15,
                    ),
                    SearchBar(searchController, searchParameter),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SelectLanguage();
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,

                                //borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).hintColor)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.globe,
                                    color: Theme.of(context).hintColor,
                                    size: 15,
                                  ),
                                  Text(
                                    'EN',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                //borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).hintColor)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.filter,
                                    color: Theme.of(context).hintColor,
                                    size: 15,
                                  ),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data?[index].name?.common!
                                        .toLowerCase()
                                        .contains(searchController.text
                                            .toLowerCase()) ==
                                    true
                                // |
                                //     (snapshot.data?[index].capital[0]
                                //             .toString()
                                //             .toLowerCase()
                                //             .contains(searchController.text
                                //                 .toLowerCase()) ==
                                //         true)
                                ) {
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: .0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${snapshot.data?[index].flags?.png}")),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        //color: Colors.grey[300],
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${snapshot.data?[index].name?.common}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1,
                                              ),
                                              Text(
                                                "${snapshot.data?[index].capital == null ? "" : snapshot.data?[index].capital[0]}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CountryDetails(
                                                index: index,
                                                countryName: snapshot
                                                    .data?[index].name?.common!,
                                              )));
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),
                    )
                  ]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Text("error");
          }),
    );
  }
}
