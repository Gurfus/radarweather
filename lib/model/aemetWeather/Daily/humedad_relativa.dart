import 'dato.dart';

class HumedadRelativa {
  int? maxima;
  int? minima;
  List<Dato>? dato;

  HumedadRelativa({this.maxima, this.minima, this.dato});

  factory HumedadRelativa.fromJson(Map<String, dynamic> json) {
    return HumedadRelativa(
      maxima: json['maxima'] as int?,
      minima: json['minima'] as int?,
      dato: (json['dato'] as List<dynamic>?)
          ?.map((e) => Dato.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'maxima': maxima,
        'minima': minima,
        'dato': dato?.map((e) => e.toJson()).toList(),
      };
}
