import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radarweather/model/aemet_id_poblaciones/aemet_id_poblaciones.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('Barcelona');

    return _database!;
  }

  Future<Database> initDB(String ciudad) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'idPoblaciones.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {
        // Llamada para buscar una ciudad después de abrir la base de datos
        buscarCiudad(db, '$ciudad').then((resultado) {
          // Procesar el resultado aquí
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> buscarCiudad(
      Database db, String nombre) async {
    List<Map<String, dynamic>> resultado = await db.rawQuery(
      'SELECT id FROM municipiosTable WHERE nombre = ?',
      [nombre],
    );
    print(resultado.first.values.first);

    return resultado;
  }

  newPoblacionRaw(AemetIdPoblaciones newPobblacion) async {
    final db = await database;

    final res = await db.insert('idPoblaciones', newPobblacion.toJson());

    return res;
  }
}
