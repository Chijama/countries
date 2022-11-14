import 'package:flutter/material.dart';
import 'package:untitled/widgets/circle_bar.dart';

import '../models/country_model.dart';
import '../service.dart';

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
  bool isLoaded = false;
  final PageController controller = PageController();
  int currentPageValue = 0;
  List<Widget> countriesList = [];

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
          jsonLocation == null ? '' : jsonLocation,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        )
      ],
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  Widget countryImage(String networkUrl) => Container(
        height: 50,
        width: 40,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(networkUrl)),
          borderRadius: BorderRadius.circular(25),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder<List<CountriesModel>>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Text("List is empty");
            }
            // setState(() {
            //   countriesList = [
            //     countryImage("${snapshot.data?[widget.index].flags?.png}"),
            //     countryImage("${snapshot.data?[widget.index].coatOfArms?.png}"),
            //   ];
            // });

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                          Text(
                            "${snapshot.data?[widget.index].name?.common}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width - 10,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          PageView(
                            physics: const ClampingScrollPhysics(),
                            //itemCount: countriesList.length,
                            onPageChanged: (int page) {
                              getChangedPageAndMoveBar(page);
                            },
                            controller: controller,
                            children: [
                              countryImage(
                                  "${snapshot.data?[widget.index].flags?.png}"),
                              countryImage(
                                  "${snapshot.data?[widget.index].coatOfArms?.png}"),
                              // countryImage(
                              //     "${snapshot.data?[widget.index].maps?.openStreetMaps}"),
                            ],
                            //itemBuilder: (context, index) {
                            // return countriesList[index];
                            //},
                          ),
                          Positioned(
                              top: 60,
                              right: 0,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  controller.nextPage(
                                      duration: const Duration(microseconds: 1),
                                      curve: Curves.easeInOut);
                                },
                              )),
                          Positioned(
                              top: 60,
                              left: 0,
                              child: IconButton(
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded),
                                onPressed: () {
                                  controller.previousPage(
                                      duration: const Duration(microseconds: 1),
                                      curve: Curves.easeInOut);
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.only(bottom: 35),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (int i = 0; i < 2; i++)
                                    if (i == currentPageValue) ...[
                                      const CircleBar(true)
                                    ] else
                                      const CircleBar(false),
                                ],
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Countrydetail(
                            "Population",
                            "${snapshot.data?[widget.index].population}",
                          ),
                          Countrydetail("Region",
                              "${snapshot.data?[widget.index].region}"),
                          Countrydetail("Capital",
                              "${snapshot.data?[widget.index].capital == null ? "" : snapshot.data?[widget.index].capital[0]}"),

                          const SizedBox(height: 24),
                          Countrydetail("Official Language",
                              "${snapshot.data?[widget.index].languages?.ara}"),
                          Countrydetail(
                              "Area", "${snapshot.data?[widget.index].area} "),
                          Countrydetail(
                            "Currency",
                            "${snapshot.data?[widget.index].currencies?.mRU}",
                          ),
                          const SizedBox(height: 24),
                          //  Countrydetail(  "Subregion",  "${snapshot.data?[widget.index].subregion}"),
                          //  Countrydetail(  "Continent",  "${snapshot.data?[widget.index].continents}"),
                          // // Countrydetail(  "Religion",  "${snapshot.data?[widget.index].}"),
                          Countrydetail("Time",
                              "${snapshot.data?[widget.index].timezones[0]}"),

                          Countrydetail(
                            "Driving Side",
                            "${snapshot.data?[widget.index].car!.side}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
