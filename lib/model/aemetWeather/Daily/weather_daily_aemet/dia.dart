import 'cota_nieve_prov.dart';
import 'estado_cielo.dart';
import 'humedad_relativa.dart';
import 'prob_precipitacion.dart';
import 'racha_max.dart';
import 'sens_termica.dart';
import 'temperatura.dart';
import 'viento.dart';

class Dia {
  List<ProbPrecipitacion>? probPrecipitacion;
  List<CotaNieveProv>? cotaNieveProv;
  List<EstadoCielo>? estadoCielo;
  List<Viento>? viento;
  List<RachaMax>? rachaMax;
  Temperatura? temperatura;
  SensTermica? sensTermica;
  HumedadRelativa? humedadRelativa;
  int? uvMax;
  String? fecha;

  Dia({
    this.probPrecipitacion,
    this.cotaNieveProv,
    this.estadoCielo,
    this.viento,
    this.rachaMax,
    this.temperatura,
    this.sensTermica,
    this.humedadRelativa,
    this.uvMax,
    this.fecha,
  });

  factory Dia.fromJson(Map<String, dynamic> json) => Dia(
        probPrecipitacion: (json['probPrecipitacion'] as List<dynamic>?)
            ?.map((e) => ProbPrecipitacion.fromJson(e as Map<String, dynamic>))
            .toList(),
        cotaNieveProv: (json['cotaNieveProv'] as List<dynamic>?)
            ?.map((e) => CotaNieveProv.fromJson(e as Map<String, dynamic>))
            .toList(),
        estadoCielo: (json['estadoCielo'] as List<dynamic>?)
            ?.map((e) => EstadoCielo.fromJson(e as Map<String, dynamic>))
            .toList(),
        viento: (json['viento'] as List<dynamic>?)
            ?.map((e) => Viento.fromJson(e as Map<String, dynamic>))
            .toList(),
        rachaMax: (json['rachaMax'] as List<dynamic>?)
            ?.map((e) => RachaMax.fromJson(e as Map<String, dynamic>))
            .toList(),
        temperatura: json['temperatura'] == null
            ? null
            : Temperatura.fromJson(json['temperatura'] as Map<String, dynamic>),
        sensTermica: json['sensTermica'] == null
            ? null
            : SensTermica.fromJson(json['sensTermica'] as Map<String, dynamic>),
        humedadRelativa: json['humedadRelativa'] == null
            ? null
            : HumedadRelativa.fromJson(
                json['humedadRelativa'] as Map<String, dynamic>),
        uvMax: json['uvMax'] as int?,
        fecha: json['fecha'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'probPrecipitacion': probPrecipitacion?.map((e) => e.toJson()).toList(),
        'cotaNieveProv': cotaNieveProv?.map((e) => e.toJson()).toList(),
        'estadoCielo': estadoCielo?.map((e) => e.toJson()).toList(),
        'viento': viento?.map((e) => e.toJson()).toList(),
        'rachaMax': rachaMax?.map((e) => e.toJson()).toList(),
        'temperatura': temperatura?.toJson(),
        'sensTermica': sensTermica?.toJson(),
        'humedadRelativa': humedadRelativa?.toJson(),
        'uvMax': uvMax,
        'fecha': fecha,
      };
}
