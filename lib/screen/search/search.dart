import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/weather_provider.dart';
import 'package:radarweather/screen/forecast/forecast.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:radarweather/screen/search/forecast_search.dart';

import '../../provider/search_provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchValue = '';

  Location? location;
  bool searchOn = false;
  bool searchBarOff = false;

  SearchProvider? searchProvider;

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    searchProvider = context.watch<SearchProvider>();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 1, 26, 64),
          Color.fromARGB(255, 24, 143, 248)
        ],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            searchBarOff == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 30.0, right: 10, left: 10),
                        child: const Icon(
                          LineIcons.alternateMapMarked,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Container(
                        height: 90,
                        padding: const EdgeInsets.only(
                            top: 30.0, right: 10, left: 10),
                        child: AnimSearchBar(
                          width: 250,
                          rtl: true,
                          color: Colors.transparent,
                          autoFocus: true,
                          boxShadow: false,
                          textFieldColor: Colors.white24,
                          textFieldIconColor: Colors.white,
                          searchIconColor: Colors.white,
                          textController: textController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          onSuffixTap: () {
                            setState(() {
                              textController.clear();
                            });
                          },
                          animationDurationInMilli: 3,
                          onSubmitted: (value) async {
                            searchValue = value;

                            // Obtener las coordenadas utilizando la función getCoordinates
                            location = await searchProvider
                                ?.getCoordinates(searchValue);

                            if (location != null) {
                              // Si se obtienen las coordenadas correctamente, llamar a los métodos necesarios del WeatherProvider
                              // searchProvider?.cancelSubcriptionn(true);
                              searchProvider?.getDataApi(
                                  location!.latitude, location!.longitude);

                              searchProvider?.cityName =
                                  await searchProvider?.getLocatonHeader(
                                      location?.latitude, location?.longitude);
                              searchBarOff = false;
                              searchOn = true;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            searchOn == false
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                      children: [
                        const Text(
                          'Busca una nueva ciudad',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Lottie.asset('assets/aemetIcons/aemet/12.json',
                            width: 128, height: 128),
                      ],
                    ),
                  )
                : const Expanded(
                    child: ForecastSearch(),
                  ),
          ],
        ),
      ),
    );
  }
}
