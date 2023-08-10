import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

import '../data/aemet/get_current_weather_aemet.dart';
import '../data/aemet/get_daily_weather_aemet.dart';
import '../data/aemet/get_hourly_weather_aemet.dart';
import '../model/aemetWeather/weather_aemet.dart';

class SearchProvider extends ChangeNotifier {
  var weatherAemet = WeatherAemet();
  bool _isLoading = true;
  bool searchOn = false;
  bool searchBarOff = false;
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
  }

  getLocatonHeader(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    String? city;
    for (var ubi in placemark) {
      if (ubi.locality != '') {
        city = ubi.locality;

        cityName = ubi.locality;
      }
    }
    return city;
  }

  Future<Location?> getCoordinates(String cityName) async {
    List<String>? citySplit;
    var containsBar = false;
    List<Location> locations;
    if (cityName.contains('/')) {
      citySplit = cityName.toString().split('/');
      containsBar = true;
    }
    try {
      if (containsBar == true) {
        for (var city in citySplit!) {
          locations = await locationFromAddress(city);
          if (locations.isNotEmpty) {
            return locations.first;
          }
        }
      } else if (containsBar == false) {
        locations = await locationFromAddress(cityName);

        if (locations.isNotEmpty) {
          Location location = locations.first;
          return location;
        } else {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  getCityName() {
    return cityName;
  }

  getSearchOn() {
    return searchOn;
  }

  getSearchBar() {
    return searchBarOff;
  }
}
