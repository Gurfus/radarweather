class SensTermica {
  String? value;
  String? periodo;

  SensTermica({
    this.value,
    this.periodo,
  });

  factory SensTermica.fromJson(Map<String, dynamic> json) => SensTermica(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
