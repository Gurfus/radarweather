class CotaNieveProv {
  String? value;
  String? periodo;

  CotaNieveProv({
    this.value,
    this.periodo,
  });

  factory CotaNieveProv.fromJson(Map<String, dynamic> json) => CotaNieveProv(
        value: json["value"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "periodo": periodo,
      };
}
