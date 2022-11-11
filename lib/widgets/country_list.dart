import '../../models/country_model.dart';
import '../service.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CountriesModel>>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Text("List is empty");
            }
            return Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${snapshot.data?[index].flags?.png}")),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              //color: Colors.grey[300],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${snapshot.data?[index].name?.common}",
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    Text(
                                      "${snapshot.data?[index].name?.common}",
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Text("error");
        });
  }
}
