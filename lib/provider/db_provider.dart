import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../helpers/estacionesIdema/calculate_near_station.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'idPoblaciones.db');
    // Copy from asset
    ByteData data =
        await rootBundle.load(join("assets", "database", "idPoblaciones.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

    //print(path);

    return await openDatabase(
      path,
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> buscarCiudad(
      Database db, String nombre) async {
    List<Map<String, dynamic>> resultado = await db.rawQuery(
      "SELECT id FROM municipiosTable WHERE nombre LIKE '%$nombre%'",
    );

    return resultado;
  }

  FutureOr<Iterable<String>> getSuggestions(String prefix, Database db) async {
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT nombre FROM municipiosTable WHERE nombre LIKE '$prefix%'",
    );

    FutureOr<Iterable<String>> suggestions =
        results.map((result) => result['nombre']);

    return suggestions;
  }

// Función para buscar la estación más cercana a una ubicación dada
  Future<Map<String, dynamic>> buscarEstacionCercana(
      double latitud, double longitud) async {
    // Abrir la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'estacionesIDEMA.db');

    // Copy from asset
    ByteData data =
        await rootBundle.load(join("assets", "database", "estacionesIDEMA.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

    Database db = await openDatabase(path, readOnly: true);

    // Consulta SQL para obtener todas las estaciones de la base de datos
    String query = 'SELECT idema,lon,lat FROM estacionesIDEMA';
    List<Map<String, dynamic>> estaciones = await db.rawQuery(query);

    // Variables para almacenar la estación más cercana
    double distanciaMinima = double.infinity;
    Map<String, dynamic>? estacionCercana;

    // Calcular la distancia entre la ubicación dada y cada estación
    for (Map<String, dynamic> estacion in estaciones) {
      double estacionLatitud = estacion['lat'];
      double estacionLongitud = estacion['lon'];

      // Calcular la distancia utilizando la fórmula de la distancia haversine
      double distancia = calculateDistance(
          latitud, longitud, estacionLatitud, estacionLongitud);

      // Actualizar la estación más cercana si la distancia es menor a la distancia mínima actual
      if (distancia < distanciaMinima) {
        distanciaMinima = distancia;
        estacionCercana = estacion;
      }
    }

    // Cerrar la base de datoss
    await db.close();

    // Devolver la estación más cercana encontrada
    //print(estacionCercana?.values.first);
    return estacionCercana ?? {};
  }

  Future<void> closeDB() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
