import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/widgets/filter.dart';

import '../models/country_model.dart';
import '../screens/details_screen.dart';
import '/service.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late Future<List<CountriesModel>> countries;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    countries = Service().getCountries();
  }

  String searchParameter = "";

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FutureBuilder<List<CountriesModel>>(
                future: countries,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return const Text("List is empty");
                    }
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // SizedBox(
                            //   height: 50,
                            // ),
                            Row(
                              children: <Widget>[
                                Text('Explore',
                                    style: GoogleFonts.elsieSwashCaps(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    )),
                                Text('.',
                                    style: GoogleFonts.elsieSwashCaps(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.orange)),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? Icon(Icons.wb_sunny_outlined)
                                        : Icon(Icons.nightlight_outlined)),
                          ],
                        ),
                        const SizedBox(height: 14),

                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              searchParameter = _searchController.text;
                            });
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white24,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).hintColor,
                            ),
                            hintText: "Search Country",
                            hintStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        // Language and Filter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // showModalBottomSheet(
                                //   context: context,
                                //   builder: (context) {
                                //     return Contains();
                                //   },
                                // );
                              },
                              child: Container(
                                //padding: const EdgeInsets.all(20.0),
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                    //color: Theme.of(context).cardColor,

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
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  //isDismissible: false,
                                  builder: (context) {
                                    return Filter();
                                  },
                                );
                              },
                              child: Container(
                                //padding: const EdgeInsets.all(20.0),
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                    //color: Theme.of(context).cardColor,
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
                        const SizedBox(height: 14),

                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data?[index].name?.common!
                                        .toLowerCase()
                                        .contains(_searchController.text
                                            .toLowerCase()) ==
                                    true) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 26),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CountryDetails(
                                                      index: index,
                                                      countryName: snapshot
                                                          .data?[index]
                                                          .name
                                                          ?.common!,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              "${snapshot.data?[index].flags?.png}",
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
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
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Text("error");
                }),
          ),
        ));
  }
}
