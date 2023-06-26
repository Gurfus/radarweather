class ProbPrecipitacion {
  int? value;
  String? periodo;

  ProbPrecipitacion({this.value, this.periodo});

  factory ProbPrecipitacion.fromJson(Map<String, dynamic> json) {
    return ProbPrecipitacion(
      value: json['value'] as int?,
      periodo: json['periodo'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'periodo': periodo,
      };
}
