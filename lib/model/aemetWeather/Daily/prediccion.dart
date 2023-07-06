import 'dia.dart';

class Prediccion {
  List<Dia>? dia;

  Prediccion({this.dia});

  factory Prediccion.fromJson(Map<String, dynamic> json) => Prediccion(
        dia: (json['dia'] as List<dynamic>?)
            ?.map((e) => Dia.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dia': dia?.map((e) => e.toJson()).toList(),
      };
}
