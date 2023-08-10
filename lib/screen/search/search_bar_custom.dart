import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';

import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:radarweather/provider/db_provider.dart';
import 'package:radarweather/provider/search_provider.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({Key? key}) : super(key: key);

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  final TextEditingController _searchController = TextEditingController();

  DbProvider? dbProvider;
  FutureOr<Iterable<String>> suggestions = [];
  String searchValue = '';

  Location? location;
  bool searchOn = false;
  bool searchBarOff = false;

  SearchProvider? searchProvider;

  @override
  Widget build(BuildContext context) {
    searchProvider = context.watch<SearchProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(
          LineIcons.alternateMapMarked,
          color: Colors.white,
          size: 30,
        ),
        title: const Text(
          'Busca una nueva ciudad',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TypeAheadField<String>(
          noItemsFoundBuilder: (context) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Text(
                'Ciudad no encontrada, selecione una de la lista',
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          },
          loadingBuilder: (context) {
            return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Colors.yellow,
                size: 30,
              ),
            );
          },
          errorBuilder: (context, error) {
            return Text(
              '$error',
              style: const TextStyle(color: Colors.redAccent),
            );
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.yellow, width: 1.0),
            ),
          ),
          suggestionsBoxController: SuggestionsBoxController(

              // Resto de los atributos del SuggestionsBoxController
              ),
          textFieldConfiguration: TextFieldConfiguration(
            cursorColor: Colors.yellowAccent,
            controller: _searchController,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.white),
              //errorText: 'No se ha encontrado la ciudad',
              labelText: 'Ciudad',
              labelStyle: const TextStyle(color: Colors.yellowAccent),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              filled: true,
              fillColor: Colors.transparent,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.yellow,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.yellow,
                  width: 1,
                ),
              ),
            ),
            textInputAction: TextInputAction.search,
            style: const TextStyle(color: Colors.white),
          ),
          suggestionsCallback: (pattern) async {
            try {
              return await getSuggestions(pattern);
            } catch (e) {
              print(e);
              throw 'Ciudad no enncontrada, use una de la lista';
            }
          },
          itemBuilder: (context, String suggestion) {
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
              child: ListTileTheme(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    title: Text(
                      suggestion,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
          onSuggestionSelected: (String suggestion) async {
            _searchController.text = suggestion;
            // Realiza alguna acción cuando se selecciona una sugerencia
            print('Ciudad seleccionada: $suggestion');
            location = await searchProvider?.getCoordinates(suggestion);
            if (location != null) {
              // Si se obtienen las coordenadas correctamente, llamar a los métodos necesarios del WeatherProvider
              // searchProvider?.cancelSubcriptionn(true);
              searchProvider?.getDataApi(
                  location!.latitude, location!.longitude);

              searchProvider?.cityName = await searchProvider?.getLocatonHeader(
                  location?.latitude, location?.longitude);
              searchProvider?.searchBarOff = false;
              searchProvider?.searchOn = true;
            }
            setState(() {});
          },
        ),
      ),
    );
  }

  FutureOr<Iterable<String>> getSuggestions(String prefix) async {
    final db = await DbProvider.db.initDB();
    FutureOr<Iterable<String>> newSuggestions =
        await DbProvider.db.getSuggestions(prefix, db);
    setState(() {
      suggestions = newSuggestions;
    });
    return suggestions;
  }
}
