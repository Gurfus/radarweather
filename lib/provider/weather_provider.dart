import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:radarweather/data/aemet/get_hourly_weather_aemet.dart';
import 'package:radarweather/data/apiWeather/get_current_weather.dart';
import 'package:radarweather/data/aemet/get_current_weather_aemet.dart';
import 'package:radarweather/data/aemet/get_daily_weather_aemet.dart';
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/aemetWeather/weather_aemet.dart';
import 'package:radarweather/model/weather/weather_current/weather_current.dart';
import 'package:radarweather/provider/db_provider.dart';

import '../model/weatherV2/weather_api/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  bool _isLoading = true;
  double lat = 0.0;
  double long = 0.0;
  DateTime now = DateTime.now();
  DateTime? time;
  Timer? searchTimer;
  bool getIsloading() => _isLoading;
  double getLat() => lat;
  double getLong() => long;
  WeatherData? weatherData;
  WeatherCurrent? weatherCurrent;
  String? cityName;
  bool geolocatorOn = true;
  var weatherAemet = WeatherAemet();

  StreamSubscription<Position>? positionStreamSubscription;
  DbProvider? dbProvider;

  getCurrentDataWeather() {
    return weatherData?.getCurrentWeatherEntity();
  }

  getHourlyDataWeather() {
    return weatherData?.getHourlyWeatherEntity();
  }

  getForecastDays() {
    return weatherData?.getForecastDays();
  }

  getCurrenAemet() {
    return weatherAemet.getCurrentWeatherAemet();
  }

  getDalyAemet() {
    return weatherAemet.getDailyAemet();
  }

  getHourlyAemet() {
    return weatherAemet.getHourlyAemet();
  }

  getCityName() {
    return cityName;
  }

  setIsloadinng(bool loading) {
    _isLoading = loading;
  }

  setCityName(String name) {
    cityName = name;
  }

  cancelSubcriptionn(bool onOff) {
    geolocatorOn = onOff;
    positionStreamSubscription?.pause();
  }

  getLocation() async {
    bool isServiceOk;
    LocationPermission locationPermission;
    isServiceOk = await Geolocator.isLocationServiceEnabled();
    if (!isServiceOk) {
      return Future.error('Service not ok');
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permition is denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Permitions are denied');
      }
    }
    searchTimer = Timer(Duration(seconds: 240), () {
      // Cancelar el stream del GPS si el tiempo máximo de búsqueda ha transcurrido
      positionStreamSubscription?.cancel();
      print(
          'Búsqueda de ubicación cancelada (tiempo máximo de búsqueda alcanzado)');
    });
    return positionStreamSubscription = Geolocator.getPositionStream(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.high))
        .listen((value) async {
      var newCity = await getLocatonHeader(value.latitude, value.longitude);
      if (cityName != newCity || cityName == null) {
        time = value.timestamp;

        _isLoading = true;
        lat = value.latitude;
        long = value.longitude;
        cityName = newCity;
        getDataApi(lat, long);
        print('data nueva');

        notifyListeners();
      }
      searchTimer!.cancel();
    });
  }

  getIdema(lat, long) async {
    final estacion = DbProvider.db.buscarEstacionCercana(lat, long);
    return estacion;
  }

  getDataApi(lat, long) async {
    _isLoading = true;
    await GetCurrentWeatherAemet().getCurrentAemet(lat, long).then((current) {
      weatherAemet.currentAemet = current;
      notifyListeners();
    });

    await GetDailyWeatherAemet().getDailyWeatherAemet(lat, long).then((daily) {
      weatherAemet.weatherDailyAemet = daily;
      notifyListeners();
    });
    await GetHourlyWeatherAemet()
        .getHourlyWeatherAemet(lat, long)
        .then((hourly) {
      weatherAemet.weatherHourlyAemet = hourly;
      _isLoading = false;
      notifyListeners();
    });
    //getIdema(lat, long);
  }

  getLocatonHeader(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    String? city;
    for (var ubi in placemark) {
      if (ubi.locality != '') {
        city = ubi.locality;
      }
    }
    return city;
  }

  Future<Location?> getCoordinates(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        print(
            'Coordenadas de $cityName: Latitud: $latitude, Longitud: $longitude');
        return location;
      } else {
        print('No se encontraron coordenadas para $cityName');
        return null;
      }
    } catch (e) {
      print('Error al obtener las coordenadas de $cityName: $e');
      return null;
    }
  }
}
