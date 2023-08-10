import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:radarweather/screen/search/forecast_search.dart';
import 'package:radarweather/screen/search/search_bar_custom.dart';

import '../../provider/search_provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchValue = '';

  Location? location;
  bool searchOn = false;
  bool searchBarOff = false;

  SearchProvider? searchProvider;

  @override
  Widget build(BuildContext context) {
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
            searchProvider?.getSearchBar() == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Icon(
                          LineIcons.alternateMapMarked,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Container(
                        height: 160,
                        child: const SearchBarCustom(),
                      ),
                    ],
                  )
                : Container(
                    color: Colors.red,
                  ),
            searchProvider?.getSearchOn() == false
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
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
