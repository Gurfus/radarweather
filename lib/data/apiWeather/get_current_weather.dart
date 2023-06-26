import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:radarweather/entities/current_weather.dart';
import 'package:radarweather/model/weather/weather_current/weather_current.dart';

import 'package:radarweather/model/weatherV2/weather_api/weather_api.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_hourly.dart';

import '../../model/weatherV2/weather_api/weather_data.dart';

class GetCurrentWeather {
  CurrentWeather? currentWeather;

  WeatherData? weatherData;
  WeatherCurrent? weatherCurrent;

  Future<WeatherData> getData(lat, long) async {
    // String api =
    //     'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=edf82667187fa430c1c83b70c45632e4&units=metric';
    String wApi =
        'http://api.weatherapi.com/v1/forecast.json?key=fb8c5b2fa12d4731978151652232504&q=$lat,$long&days=3&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(wApi));
    var jasonString = jsonDecode(response.body);

    weatherData = WeatherData(
      WeatherApi.fromJsonMap(jasonString),
    );

    return weatherData!;
  }

  // Future<WeatherCurrent> getDataCurrent(lat, long) async {
  //   // String api =
  //   //     'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=edf82667187fa430c1c83b70c45632e4&units=metric';
  //   String wApi =
  //       'http://api.weatherapi.com/v1/current.json?key=fb8c5b2fa12d4731978151652232504&q=$lat,$long&aqi=no&alerts=no';
  //   final response = await http.get(Uri.parse(wApi));
  //   var jasonString = jsonDecode(response.body);
  //   //weatherCurrent = WeatherCurrent(current: jasonString);
  //   print(j)
  //   return weatherCurrent!;
  // }
}
