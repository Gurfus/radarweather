import 'package:radarweather/model/weatherV2/weather_api/day.dart';
import 'package:radarweather/model/weatherV2/weather_api/forecastday.dart';

import 'package:radarweather/model/weatherV2/weather_api/weather_forecast_days.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_hourly.dart';

import '../../../entities/current_weather.dart';
import 'current.dart';
import 'forecast.dart';
import 'location.dart';

class WeatherApi {
  Location? location;
  Current? current;
  Forecast? forecast;

  WeatherApi({this.location, this.current, this.forecast});

  factory WeatherApi.fromJsonMap(Map<String, dynamic> json) => WeatherApi(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        current: json['current'] == null
            ? null
            : Current.fromJson(json['current'] as Map<String, dynamic>),
        forecast: json['forecast'] == null
            ? null
            : Forecast.fromJson(json['forecast'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'current': current?.toJson(),
        'forecast': forecast?.toJson(),
      };

  CurrentWeather toCurrentWeatherEntity() => CurrentWeather(
      current!.lastUpdated as String,
      current!.tempC as double,
      current!.feelslikeC as double,
      forecast!.forecastday![0].day!.mintempC as double,
      forecast!.forecastday![0].day!.maxtempC as double,
      current!.humidity as int,
      current!.pressureMb as double,
      current!.windKph as double,
      current!.condition!.code as int,
      current!.condition!.text as String,
      forecast!.forecastday![0].day!.totalprecipMm as double);

  Iterable<Iterable<Hourly>>? getHourToEntity() =>
      forecast!.forecastday!.map((e) => e.hour!.map((e) => Hourly(
          timeEpoch: e.timeEpoch,
          tempC: e.tempC,
          tempF: e.tempF,
          condition: e.condition,
          precipIn: e.precipIn,
          precipMm: e.precipMm)));

  Iterable<ForecastDays>? toForecastNextDaysEntity() =>
      forecast!.forecastday!.map((e) => ForecastDays(
          dateEpoch: e.dateEpoch,
          maxtempC: e.day!.maxtempC,
          mintempC: e.day!.mintempC,
          totalprecipMm: e.day!.totalprecipMm,
          condition: e.day!.condition,
          maxwindKph: e.day!.maxwindKph));
}
