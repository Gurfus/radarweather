import 'origen.dart';
import 'prediccion.dart';

class WeatherDailyAemet {
  Origen? origen;
  String? elaborado;
  String? nombre;
  String? provincia;
  Prediccion? prediccion;
  int? id;
  double? version;

  WeatherDailyAemet({
    this.origen,
    this.elaborado,
    this.nombre,
    this.provincia,
    this.prediccion,
    this.id,
    this.version,
  });

  factory WeatherDailyAemet.fromJson(Map<String, dynamic> json) {
    return WeatherDailyAemet(
      origen: json['origen'] == null
          ? null
          : Origen.fromJson(json['origen'] as Map<String, dynamic>),
      elaborado: json['elaborado'] as String?,
      nombre: json['nombre'] as String?,
      provincia: json['provincia'] as String?,
      prediccion: json['prediccion'] == null
          ? null
          : Prediccion.fromJson(json['prediccion'] as Map<String, dynamic>),
      id: json['id'] as int?,
      version: json['version'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'origen': origen?.toJson(),
        'elaborado': elaborado,
        'nombre': nombre,
        'provincia': provincia,
        'prediccion': prediccion?.toJson(),
        'id': id,
        'version': version,
      };

  WeatherDailyAemet getDailyAemetEntity() =>
      WeatherDailyAemet(elaborado: elaborado, prediccion: prediccion);
}
