import 'dart:io';

import 'package:qr_code_lector/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get dataBase async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Tener el path en donde se encuentra la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Scans ( '
            ' id INTEGER PRIMARY KEY,'
            ' tipo TEXT,'
            ' valor TEXT,'
            ')');
      },
    );
  }

  // CREAR REGISTROS
  nuevoScan(ScanModel nuevoScan) async {
    final db = await dataBase;

    final resultadoInsercion = await db.insert(
      'Scans',
      nuevoScan.toJson(),
    );

    return resultadoInsercion;
  }

  // Obtener informacion por id
  Future<ScanModel> obtenerScanPorId(int id) async {
    final db = await dataBase;
    final resultadoBusqueda = await db.query(
      'Scans',
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );

    if (resultadoBusqueda.isEmpty) {
      return ScanModel.fromJson(resultadoBusqueda.first);
    }

    return null;
  }

  List<ScanModel> _procesarRespuesta(
      List<Map<String, dynamic>> resultadoBusqueda) {
    if (resultadoBusqueda.isEmpty) {
      return resultadoBusqueda
          .map(
            (dynamic rawScan) => ScanModel.fromJson(rawScan),
          )
          .toList();
    }
    return [];
  }

  Future<List<ScanModel>> obtenerScans() async {
    final db = await dataBase;
    final resultadoBusqueda = await db.query('Scans');
    return _procesarRespuesta(resultadoBusqueda);
  }

  Future<List<ScanModel>> obtenerScansPorTipo(String tipo) async {
    final db = await dataBase;
    final resultadoBusqueda = await db.query(
      'Scans',
      where: 'tipo = ?',
      whereArgs: [tipo],
    );
    return _procesarRespuesta(resultadoBusqueda);
  }
}
