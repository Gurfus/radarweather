import 'origen.dart';
import 'prediccion.dart';

class WeatherHourlyAemet {
  Origen? origen;
  String? elaborado;
  String? nombre;
  String? provincia;
  Prediccion? prediccion;
  String? id;
  String? version;

  WeatherHourlyAemet({
    this.origen,
    this.elaborado,
    this.nombre,
    this.provincia,
    this.prediccion,
    this.id,
    this.version,
  });

  factory WeatherHourlyAemet.fromJson(Map<String, dynamic> json) =>
      WeatherHourlyAemet(
        origen: json['origen'] == null
            ? null
            : Origen.fromJson(json['origen'] as Map<String, dynamic>),
        elaborado: json['elaborado'] as String?,
        nombre: json['nombre'] as String?,
        provincia: json['provincia'] as String?,
        prediccion: json['prediccion'] == null
            ? null
            : Prediccion.fromJson(json['prediccion'] as Map<String, dynamic>),
        id: json['id'] as String?,
        version: json['version'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'origen': origen?.toJson(),
        'elaborado': elaborado,
        'nombre': nombre,
        'provincia': provincia,
        'prediccion': prediccion?.toJson(),
        'id': id,
        'version': version,
      };

  WeatherHourlyAemet getHourlyAemetEntity() =>
      WeatherHourlyAemet(prediccion: prediccion);
}
