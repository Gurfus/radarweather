class HumedadRelativa {
  String? value;
  String? periodo;

  HumedadRelativa({
    this.value,
    this.periodo,
  });

  factory HumedadRelativa.fromJson(Map<String, dynamic> json) =>
      HumedadRelativa(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
