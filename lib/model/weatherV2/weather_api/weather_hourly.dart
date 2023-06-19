import 'condition.dart';

class Hourly {
  int? timeEpoch;

  double? tempC;
  double? tempF;
  Condition? condition;
  double? precipMm;
  double? precipIn;

  Hourly({
    this.timeEpoch,
    this.tempC,
    this.tempF,
    this.condition,
    this.precipMm,
    this.precipIn,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        timeEpoch: json['time_epoch'] as int?,
        tempC: (json['temp_c'] as num?)?.toDouble(),
        tempF: (json['temp_f'] as num?)?.toDouble(),
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
        precipMm: (json['precip_mm'] as num?)?.toDouble(),
        precipIn: json['precip_in'] as double?,
      );
}
