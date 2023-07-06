class ProbPrecipitacion {
  String? value;
  String? periodo;

  ProbPrecipitacion({
    this.value,
    this.periodo,
  });

  factory ProbPrecipitacion.fromJson(Map<String, dynamic> json) =>
      ProbPrecipitacion(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
