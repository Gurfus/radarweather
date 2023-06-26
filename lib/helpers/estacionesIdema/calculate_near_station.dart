import 'dart:math';

double calculateDistance(
    double latCity, double longCity, double latStation, double longStation) {
  const radioTierra = 6371.0; // Radio de la Tierra en kilómetros

  // Convertir las coordenadas de latitud y longitud a radianes
  final latitudRadianesCity = _convertirARadianes(latCity);
  final longitudRadianesCity = _convertirARadianes(longCity);
  final latitudRadianesStation = _convertirARadianes(latStation);
  final longitudRadianesStation = _convertirARadianes(longStation);

  final diferenciaLatitud = latitudRadianesStation - latitudRadianesCity;
  final diferenciaLongitud = longitudRadianesStation - longitudRadianesCity;

  final a = pow(sin(diferenciaLatitud / 2), 2) +
      cos(latitudRadianesCity) *
          cos(latitudRadianesStation) *
          pow(sin(diferenciaLongitud / 2), 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  final distancia = radioTierra * c;

  return distancia;
}

double _convertirARadianes(double valor) {
  return (pi / 180) * valor;
}
