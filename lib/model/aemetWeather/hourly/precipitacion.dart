class Precipitacion {
  String? value;
  String? periodo;

  Precipitacion({
    this.value,
    this.periodo,
  });

  factory Precipitacion.fromJson(Map<String, dynamic> json) => Precipitacion(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
