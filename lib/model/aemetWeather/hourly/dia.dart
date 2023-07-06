import 'estado_cielo.dart';
import 'humedad_relativa.dart';
import 'nieve.dart';
import 'precipitacion.dart';
import 'prob_nieve.dart';
import 'prob_precipitacion.dart';
import 'prob_tormenta.dart';
import 'sens_termica.dart';
import 'temperatura.dart';
import 'viento_and_racha_max.dart';

class Dia {
  List<EstadoCielo>? estadoCielo;
  List<Precipitacion>? precipitacion;
  List<ProbPrecipitacion>? probPrecipitacion;
  List<ProbTormenta>? probTormenta;
  List<Nieve>? nieve;
  List<ProbNieve>? probNieve;
  List<Temperatura>? temperatura;
  List<SensTermica>? sensTermica;
  List<HumedadRelativa>? humedadRelativa;
  List<VientoAndRachaMax>? vientoAndRachaMax;
  String? fecha;
  String? orto;
  String? ocaso;

  Dia({
    this.estadoCielo,
    this.precipitacion,
    this.probPrecipitacion,
    this.probTormenta,
    this.nieve,
    this.probNieve,
    this.temperatura,
    this.sensTermica,
    this.humedadRelativa,
    this.vientoAndRachaMax,
    this.fecha,
    this.orto,
    this.ocaso,
  });

  factory Dia.fromJson(Map<String, dynamic> json) => Dia(
        estadoCielo: (json['estadoCielo'] as List<dynamic>?)
            ?.map((e) => EstadoCielo.fromJson(e as Map<String, dynamic>))
            .toList(),
        precipitacion: (json['precipitacion'] as List<dynamic>?)
            ?.map((e) => Precipitacion.fromJson(e as Map<String, dynamic>))
            .toList(),
        probPrecipitacion: (json['probPrecipitacion'] as List<dynamic>?)
            ?.map((e) => ProbPrecipitacion.fromJson(e as Map<String, dynamic>))
            .toList(),
        probTormenta: (json['probTormenta'] as List<dynamic>?)
            ?.map((e) => ProbTormenta.fromJson(e as Map<String, dynamic>))
            .toList(),
        nieve: (json['nieve'] as List<dynamic>?)
            ?.map((e) => Nieve.fromJson(e as Map<String, dynamic>))
            .toList(),
        probNieve: (json['probNieve'] as List<dynamic>?)
            ?.map((e) => ProbNieve.fromJson(e as Map<String, dynamic>))
            .toList(),
        temperatura: (json['temperatura'] as List<dynamic>?)
            ?.map((e) => Temperatura.fromJson(e as Map<String, dynamic>))
            .toList(),
        sensTermica: (json['sensTermica'] as List<dynamic>?)
            ?.map((e) => SensTermica.fromJson(e as Map<String, dynamic>))
            .toList(),
        humedadRelativa: (json['humedadRelativa'] as List<dynamic>?)
            ?.map((e) => HumedadRelativa.fromJson(e as Map<String, dynamic>))
            .toList(),
        vientoAndRachaMax: (json['vientoAndRachaMax'] as List<dynamic>?)
            ?.map((e) => VientoAndRachaMax.fromJson(e as Map<String, dynamic>))
            .toList(),
        fecha: json['fecha'] as String?,
        orto: json['orto'] as String?,
        ocaso: json['ocaso'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'estadoCielo': estadoCielo?.map((e) => e.toJson()).toList(),
        'precipitacion': precipitacion?.map((e) => e.toJson()).toList(),
        'probPrecipitacion': probPrecipitacion?.map((e) => e.toJson()).toList(),
        'probTormenta': probTormenta?.map((e) => e.toJson()).toList(),
        'nieve': nieve?.map((e) => e.toJson()).toList(),
        'probNieve': probNieve?.map((e) => e.toJson()).toList(),
        'temperatura': temperatura?.map((e) => e.toJson()).toList(),
        'sensTermica': sensTermica?.map((e) => e.toJson()).toList(),
        'humedadRelativa': humedadRelativa?.map((e) => e.toJson()).toList(),
        'vientoAndRachaMax': vientoAndRachaMax?.map((e) => e.toJson()).toList(),
        'fecha': fecha,
        'orto': orto,
        'ocaso': ocaso,
      };
}
