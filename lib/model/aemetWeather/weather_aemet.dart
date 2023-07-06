import 'package:radarweather/model/aemetWeather/Current/current_aemet/current_aemet.dart';
import 'package:radarweather/model/aemetWeather/Daily/weather_daily_aemet.dart';
import 'package:radarweather/model/aemetWeather/hourly/weather_hourly_aemet.dart';

class WeatherAemet {
  CurrentAemet? currentAemet;
  WeatherDailyAemet? weatherDailyAemet;
  WeatherHourlyAemet? weatherHourlyAemet;

  WeatherAemet(
      {this.currentAemet, this.weatherDailyAemet, this.weatherHourlyAemet});

  CurrentAemet getCurrentWeatherAemet() =>
      currentAemet!.getCurrentAemetEntity();

  WeatherDailyAemet getDailyAemet() => weatherDailyAemet!.getDailyAemetEntity();

  WeatherHourlyAemet getHourlyAemet() =>
      weatherHourlyAemet!.getHourlyAemetEntity();
}
