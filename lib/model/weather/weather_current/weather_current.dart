import 'current.dart';
import 'location.dart';

class WeatherCurrent {
  Location? location;
  Current? current;

  WeatherCurrent({this.location, this.current});

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      current: json['current'] == null
          ? null
          : Current.fromJson(json['current'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'current': current?.toJson(),
      };
  getTempReal() {
    return {current!.tempC, current!.tempF};
  }
}
