class Temperatura {
  String? value;
  String? periodo;

  Temperatura({
    this.value,
    this.periodo,
  });

  factory Temperatura.fromJson(Map<String, dynamic> json) => Temperatura(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
