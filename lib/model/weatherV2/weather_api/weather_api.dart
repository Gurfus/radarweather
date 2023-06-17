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
      current!.tempC as double,
      current!.feelslikeC as double,
      forecast!.forecastday![0].day!.mintempC as double,
      forecast!.forecastday![0].day!.maxtempC as double,
      current!.humidity as int,
      current!.pressureMb as double,
      current!.windKph as double,
      current!.condition!.code as int,
      current!.condition!.text as String);
}
