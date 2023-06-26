class Origen {
  String? productor;
  String? web;
  String? enlace;
  String? language;
  String? copyright;
  String? notaLegal;

  Origen({
    this.productor,
    this.web,
    this.enlace,
    this.language,
    this.copyright,
    this.notaLegal,
  });

  factory Origen.fromJson(Map<String, dynamic> json) => Origen(
        productor: json['productor'] as String?,
        web: json['web'] as String?,
        enlace: json['enlace'] as String?,
        language: json['language'] as String?,
        copyright: json['copyright'] as String?,
        notaLegal: json['notaLegal'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'productor': productor,
        'web': web,
        'enlace': enlace,
        'language': language,
        'copyright': copyright,
        'notaLegal': notaLegal,
      };
}
