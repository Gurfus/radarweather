import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radarweather/data/get_current_weather.dart';
import 'package:radarweather/data/get_poblaciones.dart';
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_data.dart';
import 'package:radarweather/model/weather/weather_current/weather_current.dart';

import '../model/weatherV2/weather_api/weather_data.dart';

class WeatherProvider extends ChangeNotifier {
  bool _isLoading = true;
  double lat = 0.0;
  double long = 0.0;

  bool getIsloading() => _isLoading;
  double getLat() => lat;
  double getLong() => long;
  WeatherData? weatherData;
  WeatherCurrent? weatherCurrent;
  AemetIdData? aemetIdData;

  getCurrentDataWeather() {
    return weatherData!.getCurrentWeatherEntity();
  }

  getHourlyDataWeather() {
    return weatherData!.getHourlyWeatherEntity();
  }

  getForecastDays() {
    return weatherData!.getForecastDays();
  }

  getPoblaciones() {
    return aemetIdData!.getIdData();
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
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      lat = value.latitude;
      long = value.longitude;

      return GetCurrentWeather().getData(lat, long).then((value) {
        weatherData = value;
        _isLoading = false;
        notifyListeners();
      });
    });
  }

  getDataPoblaciones() async {
    return await GetPoblaciones().getIdPoblaciones().then((value) {
      aemetIdData = value;
      notifyListeners();
    });
  }
}
