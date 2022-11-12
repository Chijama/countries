import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../service.dart';
import '../models/country_model.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails(
      {super.key, required this.index, required this.countryName});

  final int index;
  final String? countryName;

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
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

  Widget Countrydetail(String field, String jsonLocation) {
    return Row(
      children: [
        Text(
          "$field:",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          jsonLocation,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder<List<CountriesModel>>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Text("List is empty");
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    Text(
                      "${snapshot.data?[widget.index].name?.common}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                CarouselSlider(
                  items: [
                    Image.network(
                      "${snapshot.data?[widget.index].flags?.png}",
                    ),
                    Image.network(
                        "${snapshot.data?[widget.index].coatOfArms?.png}")
                  ],
                  options: CarouselOptions(
                    pageSnapping: true,
                    height: 200,
                  ),
                ),
                SizedBox(height: 24),
                Countrydetail(
                  "Population",
                  "${snapshot.data?[widget.index].population}",
                ),
                Countrydetail(
                    "Region", "${snapshot.data?[widget.index].region}"),
                Countrydetail("Capital",
                    "${snapshot.data?[widget.index].capital == null ? "" : snapshot.data?[widget.index].capital[0]}"),
                SizedBox(height: 24),
                Countrydetail("Official Language",
                    "${snapshot.data?[widget.index].languages!.ara}"),
                // Countrydetail(  "Religion",  "${snapshot.data?[widget.index].}"),
                // Countrydetail(  "Religion",  "${snapshot.data?[widget.index].}"),
                // Countrydetail(  "Religion",  "${snapshot.data?[widget.index].}"),
                // Countrydetail(  "Religion",  "${snapshot.data?[widget.index].}"),
                Countrydetail(
                    "Time", "${snapshot.data?[widget.index].timezones[0]}"),
                Countrydetail(
                  "Currency",
                  "${snapshot.data?[widget.index].currencies!.mRU}",
                ),
                Countrydetail(
                  "Driving Side",
                  "${snapshot.data?[widget.index].car!.side}",
                ),
              ],
            );
          } else {
            return Text("error");
          }
        },
      ),
    );
  }
}
