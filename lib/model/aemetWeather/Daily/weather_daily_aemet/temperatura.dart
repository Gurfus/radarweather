import 'dato.dart';

class Temperatura {
  int? maxima;
  int? minima;
  List<Dato>? dato;

  Temperatura({this.maxima, this.minima, this.dato});

  factory Temperatura.fromJson(Map<String, dynamic> json) => Temperatura(
        maxima: json['maxima'] as int?,
        minima: json['minima'] as int?,
        dato: (json['dato'] as List<dynamic>?)
            ?.map((e) => Dato.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'maxima': maxima,
        'minima': minima,
        'dato': dato?.map((e) => e.toJson()).toList(),
      };
}
