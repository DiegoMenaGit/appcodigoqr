import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/scan_models.dart';

class DBProvider {
  // Todas las consultas y acciones de la base de datos
  static Database? _database;
  static DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //Obtenir path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);
    //Creacio de la BBDD

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE Scans(
  id INTEGER PRIMARY KEY,
  tipus TEXT,
  valor TEXT
)
''');
    });
  }

  Future<int> inserRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;
    final res = await db.rawInsert(''' 
      INSERT INTO Scans(id, tipus, valor)
      VALUES ($id, $tipus, $valor)
    ''');
    return res;
  }

  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;

    final res = await db.insert('Scans', nouScan.toMap());
    print(res);
    return res;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  Future<List<ScanModel>?> getScanByTipus(String tipus) async {
    final db = await database;
    final res = await db.rawQuery('''
 SELECT * FROM Scans WHERE tipus = "$tipus"
''');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = db.update('Scans', nouScan.toMap(),
        where: 'id = ?', whereArgs: [nouScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM Scans where id = $id
''');
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete(''' 
    DELETE FROM Scans
    ''');
    return res;
  }
}
