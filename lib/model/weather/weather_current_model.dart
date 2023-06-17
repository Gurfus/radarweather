import 'package:radarweather/entities/current_weather.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main.dart';
import 'sys.dart';
import 'wind.dart';
import 'weather.dart';

class WeatherCurrentModel {
  Coord? coord;
  Weather? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherCurrentModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherCurrentModel.fromJsonMap(Map<String, dynamic> json) =>
      WeatherCurrentModel(
        coord: json['coord'] == null
            ? null
            : Coord.fromJson(json['coord'] as Map<String, dynamic>),
        weather: json['main'] == null
            ? null
            : Weather.fromJsonMap(json['weather'] as List<dynamic>),
        base: json['base'] as String?,
        main: json['main'] == null
            ? null
            : Main.fromJson(json['main'] as Map<String, dynamic>),
        visibility: json['visibility'] as int?,
        wind: json['wind'] == null
            ? null
            : Wind.fromJson(json['wind'] as Map<String, dynamic>),
        clouds: json['clouds'] == null
            ? null
            : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
        dt: json['dt'] as int?,
        sys: json['sys'] == null
            ? null
            : Sys.fromJson(json['sys'] as Map<String, dynamic>),
        timezone: json['timezone'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        cod: json['cod'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'weather': weather?.toJson(),
        'base': base,
        'main': main?.toJson(),
        'visibility': visibility,
        'wind': wind?.toJson(),
        'clouds': clouds?.toJson(),
        'dt': dt,
        'sys': sys?.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };

  CurrentWeather toCurrentWeatherEntity() => CurrentWeather(
      main!.temp as double,
      main!.feelsLike as double,
      main!.tempMin as double,
      main!.tempMax as double,
      main!.humidity as int,
      main!.pressure as double,
      wind!.speed as double,
      weather!.icon as int,
      weather!.description);
}
