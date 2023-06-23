import 'condition.dart';

class ForecastDays {
  int? dateEpoch;
  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  double? mintempF;
  double? avgtempC;
  double? avgtempF;
  double? maxwindMph;
  double? maxwindKph;
  double? totalprecipMm;
  double? totalprecipIn;

  double? avgvisKm;
  double? avgvisMiles;
  double? avghumidity;

  Condition? condition;

  ForecastDays({
    this.dateEpoch,
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.condition,
  });

  factory ForecastDays.fromJson(Map<String, dynamic> json) => ForecastDays(
        maxtempC: (json['maxtemp_c'] as num?)?.toDouble(),
        maxtempF: (json['maxtemp_f'] as num?)?.toDouble(),
        mintempC: (json['mintemp_c'] as num?)?.toDouble(),
        mintempF: (json['mintemp_f'] as num?)?.toDouble(),
        avgtempC: (json['avgtemp_c'] as num?)?.toDouble(),
        avgtempF: (json['avgtemp_f'] as num?)?.toDouble(),
        maxwindMph: (json['maxwind_mph'] as num?)?.toDouble(),
        maxwindKph: (json['maxwind_kph'] as num?)?.toDouble(),
        totalprecipMm: (json['totalprecip_mm'] as num?)?.toDouble(),
        totalprecipIn: (json['totalprecip_in'] as num?)?.toDouble(),
        avgvisKm: (json['avgvis_km'] as num?)?.toDouble(),
        avgvisMiles: json['avgvis_miles'] as double?,
        avghumidity: json['avghumidity'] as double?,
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
      );
}
