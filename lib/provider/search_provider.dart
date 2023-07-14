import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

import '../data/aemet/get_current_weather_aemet.dart';
import '../data/aemet/get_daily_weather_aemet.dart';
import '../data/aemet/get_hourly_weather_aemet.dart';
import '../model/aemetWeather/weather_aemet.dart';

class SearchProvider extends ChangeNotifier {
  var weatherAemet = WeatherAemet();
  bool _isLoading = true;
  String? cityName;
  bool getIsloading() => _isLoading;
  getCurrenAemet() {
    return weatherAemet.getCurrentWeatherAemet();
  }

  getDalyAemet() {
    return weatherAemet.getDailyAemet();
  }

  getHourlyAemet() {
    return weatherAemet.getHourlyAemet();
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
    Placemark place = placemark[0];
    cityName = place.locality;
    return place.locality;
  }

  Future<Location?> getCoordinates(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        return location;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  getCityName() {
    return cityName;
  }
}