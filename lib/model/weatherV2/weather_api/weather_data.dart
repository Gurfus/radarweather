import 'package:radarweather/entities/current_weather.dart';

import 'package:radarweather/model/weatherV2/weather_api/weather_api.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_forecast_days.dart';
import 'package:radarweather/model/weatherV2/weather_api/weather_hourly.dart';

class WeatherData {
  WeatherApi? weatherApi;
  CurrentWeather? currentWeather;
  Hourly? hourly;
  ForecastDays? forecastDays;

  WeatherData([this.weatherApi]);

  WeatherApi getCurrentWeahter() => weatherApi!;

  CurrentWeather getCurrentWeatherEntity() =>
      weatherApi!.toCurrentWeatherEntity();

  Iterable<Iterable<Hourly>>? getHourlyWeatherEntity() =>
      weatherApi!.getHourToEntity();

  Iterable<ForecastDays>? getForecastDays() =>
      weatherApi!.toForecastNextDaysEntity();
}
