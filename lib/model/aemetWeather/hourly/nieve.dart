class Nieve {
  String? value;
  String? periodo;

  Nieve({
    this.value,
    this.periodo,
  });

  factory Nieve.fromJson(Map<String, dynamic> json) => Nieve(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
